output "vm_nics" {
  value = azurerm_network_interface.nic
}

 

output "encrypted_password" {
  value = var.vm_count > 0 ? data.external.password[0].result["result"] : ""
}

 

output "vm_attributes" {
  value = [
    for i in range(length(azurerm_windows_virtual_machine.vm)) : tomap({
      "id" =  azurerm_windows_virtual_machine.vm[i].id,
      "name"= azurerm_windows_virtual_machine.vm[i].name,
      "private_ip_address" = azurerm_network_interface.nic[i].private_ip_address,
      "principal_id" = azurerm_windows_virtual_machine.vm[i].identity.0.principal_id,
      "zones" = azurerm_windows_virtual_machine.vm[i].zone
})
  ]
}

 

output "data_disk_name" {
  value = {
    for data_disk in azurerm_managed_disk.data_disk :
    data_disk.id => data_disk.name
  }
}

 