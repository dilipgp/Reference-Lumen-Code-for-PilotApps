# Returns the output of storage account name created here
output "storage_account" {
  value = {
    id                  = azurerm_storage_account.storage.0.id
    name                = azurerm_storage_account.storage.0.name
    resource_group_name = azurerm_storage_account.storage.0.resource_group_name
    location            = azurerm_storage_account.storage.0.location
    identity            = azurerm_storage_account.storage.0.identity
    primary_location    = azurerm_storage_account.storage.0.primary_location
    secondary_location  = azurerm_storage_account.storage.0.secondary_location
  }
}
 
output "storage_account_primary_secret" {
  sensitive = true
  value = {
    primary_access_key             = azurerm_storage_account.storage.0.primary_access_key
    primary_blob_connection_string = azurerm_storage_account.storage.0.primary_blob_connection_string
  }
}
 
output "storage_account_secondary_secret" {
  sensitive = true
  value = {
    primary_access_key             = azurerm_storage_account.storage.0.secondary_access_key
    primary_blob_connection_string = azurerm_storage_account.storage.0.secondary_blob_connection_string
  }
}
 
 
#output "private_endpoint_ip_address" {
#  value = {
#    for k, v in azurerm_private_endpoint.ep : k => v.private_service_connection.0.private_ip_address
#  }
#}