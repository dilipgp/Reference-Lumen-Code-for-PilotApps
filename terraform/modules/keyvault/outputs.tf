output "keyvault_name" {
  value = azurerm_key_vault.key_vault.name
}
 
output "keyvault_id" {
  value = azurerm_key_vault.key_vault.id
}
 
output "keyvault_resource_group" {
  value = azurerm_key_vault.key_vault.resource_group_name
}
 
output "keyvault_location" {
  value = azurerm_key_vault.key_vault.location
}
 
output "keyvault_vault_uri" {
  value = azurerm_key_vault.key_vault.vault_uri
}
 
#output "keyvault_private_endpoint_private_IP" {
#  value = azurerm_private_endpoint.ep[*].private_service_connection.0.private_ip_address
#}
 
#output "key_id" {
#  value = azurerm_key_vault_key.key.id
#}