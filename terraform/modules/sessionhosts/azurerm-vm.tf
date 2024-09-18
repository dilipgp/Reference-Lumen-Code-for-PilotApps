data "azurerm_resources" "disk_encryption_set" {
  count = signum(var.vm_count)
  type  = "Microsoft.Compute/diskEncryptionSets"
  //  resource_group_name = var.rg.name
  required_tags = {
    component = "DefaultDiskEncryptionSet"
    location  = var.rg.location
  }
}

 

resource "azurerm_availability_set" "as" {
  count                        = local.zone_support[var.rg.location] ? 0 : 1
  name                         = var.vm_count == 1 ? "vm-${var.vm_name}-availabilityset" : format("vm-%s%03davailabilityset", var.vm_name, count.index + 1)
  location                     = var.rg.location
  resource_group_name          = var.rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = var.tag_map
}
// If more that one vm, could opt to span across az (or a set, if not support zone)

 

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = var.vm_count == 1 ? "nic-${var.vm_name}" : format("nic-%s%03d", var.vm_name, count.index + 1)
  location            = var.rg.location
  resource_group_name = var.rg.name
  tags                = var.tag_map
  ip_configuration {
    name                          = var.vm_count == 1 ? "nic-${var.vm_name}" : format("nic-%s%03d", var.vm_name, count.index + 1)
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

 

  //Change done as part of JIRA [AZCORE-81] to enable accelerated networking
  enable_accelerated_networking = var.enable_accelerated_networking
}

 

data "azurerm_resources" "kv" {
  provider = azurerm
  type     = "Microsoft.KeyVault/vaults"
  resource_group_name  = "infra-eastasia-rg"
  required_tags = {
    maintained_by =  "azure-subscription-baseline"
}
}

 

data "azurerm_key_vault_secret" "vmosadminpassword" {
  name         = "vmosadminpassword"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}

 

resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.vm_count 
  name                = var.vm_count == 1 ? var.vm_name : format("%s%03d", var.vm_name, count.index + 1)
  resource_group_name = var.rg.name
  location            = var.rg.location
  size                = var.vm_size
  admin_username      = var.vm_osadmin_user
  admin_password      = data.azurerm_key_vault_secret.vmosadminpassword.value
  availability_set_id = local.zone_support[var.rg.location] ? null : azurerm_availability_set.as[0].id
  zone                = local.zone_support[var.rg.location] ? count.index % 3 + 1 : null
  computer_name       = var.vm_count == 1 ? var.vm_name : format("%s%03d", var.vm_name, count.index + 1)
  tags                = var.tag_map
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

 

  os_disk {
    name                   = format("osdisk-%s%s-%s", var.vm_name, (var.vm_count == 1 ? "" : format("-%03d", count.index + 1)), local.vm_disk_suffix)
    caching                = "ReadWrite"
    storage_account_type   = var.vm_disk_type
#    disk_encryption_set_id = data.azurerm_resources.disk_encryption_set[0].resources[0].id
    disk_size_gb           = var.disk_size_gb
  }
  provision_vm_agent = true

 

  identity {
    type         = length(var.managed_identity_ids) > 0 ? "UserAssigned " : "SystemAssigned"
    identity_ids = length(var.managed_identity_ids) > 0 ? var.managed_identity_ids : null
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-evd"
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [
      os_disk[0].name, admin_username, admin_password
    ]
  }
}

 

resource "azurerm_managed_disk" "data_disk" {
  for_each               = local.instance_disks
  name                   = format("datadisk_%s_disk%02d", azurerm_windows_virtual_machine.vm[each.value.vm_index].name, each.value.lun)
  location               = var.rg.location
  resource_group_name    = var.rg.name
  storage_account_type   = var.storage_account_type
  disk_size_gb           = each.value.disk_size
  create_option          = var.create_option
#  disk_encryption_set_id = data.azurerm_resources.disk_encryption_set[0].resources[0].id
  zone                   = local.zone_support[var.rg.location] ? azurerm_windows_virtual_machine.vm[each.value.vm_index].zone : ""
  max_shares             = var.max_shares_number
  lifecycle {
    ignore_changes = [
      storage_account_type
    ]
  }
}

 

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  for_each           = local.instance_disks
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm[each.value.vm_index].id
  lun                = each.value.lun
  caching            = var.caching
  create_option      = var.data_disk_create_option
}

 

data "external" "password" {
  count   = signum(var.vm_count)
  program = ["bash", "${path.module}/scripts/encrypt.sh"]
  query = {
    secret         = data.azurerm_key_vault_secret.vmosadminpassword.value
    pem_public_key = var.pem_public_key
  }
}

 

resource "azurerm_virtual_machine_extension" "windows_custom_script" {
  count                = var.vm_extension_enabled ? var.vm_count : 0
  name                 = "customScript"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  virtual_machine_id   = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
  settings             = var.extension_settings
  protected_settings   = var.extension_protected_settings
  tags                 = var.tag_map
  timeouts {
    create = var.create_timeout
  }
  depends_on = [azurerm_virtual_machine_extension.domainjoin]
}

 

 

data "azurerm_key_vault" "keyvault" {
  name                = data.azurerm_resources.kv.resources[0].name
  resource_group_name      = "infra-eastasia-rg"
}

 

data "azurerm_key_vault_secret" "domainpassword" {
  name         = "domainpasword"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}

 

data "azurerm_key_vault_secret" "domainuser" {
  name         = "domainuser"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}

 

resource "azurerm_virtual_machine_extension" "domainjoin" {
  count                = var.domainjoin ? var.vm_count : 0
  name                 = format("%sDJ", element(azurerm_windows_virtual_machine.vm.*.name, count.index))
  virtual_machine_id   = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings             = <<SETTINGS
      {
      "Name": "${var.environment == "development" ? local.domain.dev : local.domain.prd}",
      "OUPath": "${var.OUPath}",
      "User": "${data.azurerm_key_vault_secret.domainuser.value}",
      "Restart": "true",
      "Options": "3"
      }
      SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
      {
      "Password": "${data.azurerm_key_vault_secret.domainpassword.value}"
      }
      PROTECTED_SETTINGS

 

}

 

resource "azurerm_network_interface_security_group_association" "nsg_associate" {
  count                     = var.network_sg != null ? var.vm_count : 0
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = var.network_sg.id
}
############
resource "azurerm_virtual_machine_extension" "wvd_dsc" {
  count                        = var.wvddsc_enable ? var.vm_count: 0
  name                         = format("%swvd", element(azurerm_windows_virtual_machine.vm.*.name, count.index))
  publisher                    = "Microsoft.Powershell"
  type                         = "DSC"
  type_handler_version         = "2.73"
  auto_upgrade_minor_version = true
  virtual_machine_id           = element(azurerm_windows_virtual_machine.vm.*.id, count.index)

  settings = <<SETTINGS
    {             
     "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip",
     "configurationFunction": "Configuration.ps1\\AddSessionHost",
     "properties": {
      "hostPoolName": "${var.hostpoolname}",
      "registrationInfoToken": "${var.hostpoolregtoken}"
    }
    }
SETTINGS
  tags = var.tag_map
  #depends_on = [azurerm_virtual_machine_extension.domainjoin]
}
/*
resource "null_resource" "win_msix_custom_script" {
  count                = var.msix_enabled ? var.vm_count : 0
    provisioner "local-exec" {
    command = "${file("${path.module}/scripts/MSIXpackage.ps1")} -packageaction ${var.packageaction} -SubscriptionName ${var.deployment_subscription_name} -HostPoolName ${var.hostpoolname} -ResourceGroupName ${var.msix_rg} -ImageUNCPath ${var.ImageUNCPath} -DisplayName ${var.PackageDisplayName}"
  #command = "Get-Date > completed.txt"
  #interpreter = ["PowerShell", "-File"]
  interpreter = ["pwsh", "-Command"]
    }
}

 

 

##MSIX packages installation.
resource "null_resource" "win_msix_custom_script" {
  count                = var.msix_enabled ? var.vm_count : 0
  triggers = {
      HostPoolName = var.hostpoolname
      SubscriptionName = var.deployment_subscription_name
      ResourceGroupName = var.rg.name
      ImageUNCPath = var.ImageUNCPath
      PackageDisplayName = var.PackageDisplayName
  }
provisioner "local-exec" {
  command = "Out-File -filepath addMSIXpack.ps1 && powershell -ExecutionPolicy Unrestricted -File ${file("${path.module}/scripts/addMSIXpack.ps1")} --HostPoolName ${self.triggers.HostPoolName} --SubscriptionName ${self.triggers.SubscriptionName} --ResourceGroupName ${self.triggers.ResourceGroupName} --ImageUNCPath ${self.triggers.ImageUNCPath} --PackageDisplayName ${self.triggers.PackageDisplayName}"
  #command = "${file("${path.module}\\scripts\\addMSIXpack.ps1")}"
   #command = "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath addMSIXpack.ps1\" && powershell -ExecutionPolicy Unrestricted -File addMSIXpack.ps1"
   interpreter = ["PowerShell","-Command"]
}
# depends_on = [azurerm_windows_virtual_machine.vm,    
    #azurerm_virtual_machine_extension.wvd_dsc,azurerm_virtual_machine_extension.domainjoin]
}
data "template_file" "tf" {
    template = "${file("${path.module}/scripts/addMSIXpack.ps1")}"
}

 

resource "null_resource" "win_msix_custom_script" {
  count                = var.msix_enabled ? var.vm_count : 0
  triggers = {
      HostPoolName = var.hostpoolname
      SubscriptionName = var.deployment_subscription_name
      ResourceGroupName = var.rg.name
      ImageUNCPath = var.ImageUNCPath
      PackageDisplayName = var.PackageDisplayName
  }
  provisioner "local-exec" {
     "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath addMSIXpack.ps1\" && powershell -ExecutionPolicy Unrestricted -File addMSIXpack.ps1"
  }
# depends_on = [azurerm_windows_virtual_machine.vm,azurerm_virtual_machine_extension.wvd_dsc,azurerm_virtual_machine_extension.domainjoin]
}
*/