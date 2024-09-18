#Perform all data plane operations on a key vault and all objects in it, including certificates, keys, and secrets. Cannot manage key vault resources or manage role assignments.
 
resource "azurerm_role_assignment" "admin" {
  for_each             = toset(var.keyvault_admin_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value
}
 
#Perform any action on the keys of a key vault, except manage permissions.
resource "azurerm_role_assignment" "keys_writer" {
  for_each             = toset(var.keyvault_key_writer_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = each.value
}
 
#Perform any action on the secrets of a key vault, except manage permissions.
resource "azurerm_role_assignment" "secrets_writer" {
  for_each             = toset(var.keyvault_secret_writer_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}
 
#Perform any action on the certificates of a key vault, except manage permissions.
resource "azurerm_role_assignment" "certificate_writer" {
  for_each             = toset(var.keyvault_certificate_writer_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = each.value
}
 
#Key Vault Reader: Read metadata of key vaults and its certificates, keys, and secrets. Cannot read sensitive values such as secret contents or key material.
resource "azurerm_role_assignment" "reader" {
  for_each             = toset(var.keyvault_reader_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = each.value
}
 
#Read secret contents including secret portion of a certificate with private key.
resource "azurerm_role_assignment" "secret_reader" {
  for_each             = toset(var.keyvault_secert_reader_ids)
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}