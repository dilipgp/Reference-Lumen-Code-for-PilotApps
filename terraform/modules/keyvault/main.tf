data "azurerm_subscription" "current" {}
 
# Source code for  the Key Vault Creation
resource "azurerm_key_vault" "key_vault" {
  name                            = "kv-cds-${var.env_short_name}-${var.location_short}-${var.kv_instance}"
  location                        = var.region
  resource_group_name             = var.resource_group
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_subscription.current.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  tags                            = merge(var.tag_map, { tier = "spoke" })
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = var.whitelist_ips
  }
 
  lifecycle {
    ignore_changes = [soft_delete_retention_days]
  }
}
 
resource "azurerm_management_lock" "kv_lock" {
  count      = var.azure_resource_lock_enable ? 1 : 0
  name       = "ResourceLockedByPolicy"
  scope      = azurerm_key_vault.key_vault.id
  lock_level = "CanNotDelete"
  notes      = "Locked by Azure Policy"
}