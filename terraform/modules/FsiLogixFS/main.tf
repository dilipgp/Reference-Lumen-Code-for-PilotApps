# Code to Retrive the Provider details

resource "azurerm_storage_account" "storage" {
  count                    = var.enable_storage ? 1 : 0
  name                     = "stcdssfs${var.countrycode}hp${var.environment}${var.region_suffix}001"
  resource_group_name      = var.resource_group_name 
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier                     = "Hot"
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  public_network_access_enabled   = true
  identity {
    type = "SystemAssigned"
  }
  azure_files_authentication {
    directory_type = "AADKERB"
  }
  network_rules {
    default_action = "Allow"
#
#    # Allow traffic from specific CIDRs
#    ip_rules = ["20.41.194.0/24", "20.204.197.192/26", "20.195.68.0/24"]
  }
}

resource "azurerm_storage_share" "fileshare" {
  count                = var.enable_storage ? 1 : 0
  name                 = "fs-fslx-01"
  storage_account_name = azurerm_storage_account.storage[count.index].name
  quota                = 300
}

resource "azurerm_private_endpoint" "storage_account" {
  count                         = var.enable_storage ? 1 : 0
  name                          = "pe-${azurerm_storage_account.storage[count.index].name}"
  location                      = var.region
  resource_group_name           = var.resource_group_name 
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pe-${azurerm_storage_account.storage[count.index].name}"
  private_service_connection {
    name                           = azurerm_storage_account.storage[count.index].name
    private_connection_resource_id = azurerm_storage_account.storage[count.index].id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
}


# Grant Key Vault resource Owner data plane permission for Diagnostic Storage Account
resource "azurerm_key_vault_access_policy" "storage_account" {
  count        = var.enable_storage ? 1 : 0
  key_vault_id = var.keyvault
  tenant_id    = data.azurerm_subscription.current.tenant_id
  object_id    = azurerm_storage_account.storage[0].identity.0.principal_id
  key_permissions = [
    "Get",
    "Recover",
    "UnwrapKey",
    "WrapKey",
    "Restore",
    "Purge",
  ]
}

 

# encryption key for storage account
resource "azurerm_key_vault_key" "storage_account_enc_key" {
  count        = var.enable_storage ? 1 : 0
  name         = "${azurerm_storage_account.storage[count.index].name}-storage-account-encryption-key"
  key_vault_id = var.keyvault
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  depends_on = [azurerm_key_vault_access_policy.storage_account]
}


resource "azurerm_storage_account_customer_managed_key" "storage_account_cmk" {
  count              = var.enable_storage ? 1 : 0
  storage_account_id = azurerm_storage_account.storage[0].id
  key_vault_id       = var.keyvault
  key_name           = azurerm_key_vault_key.storage_account_enc_key[0].name
}