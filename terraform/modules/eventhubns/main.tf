data "azurerm_subscription" "current" {}
 
# Create Event Hub Namespace
resource "azurerm_eventhub_namespace" "this" {
  name                = var.namespace_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = local.evhn_sku
  zone_redundant      = contains(local.az_supported_region_list, var.resource_group.location)
  capacity            = var.capacity
 
  tags                         = var.tag_map
  local_authentication_enabled = false
  minimum_tls_version          = 1.2
 
  network_rulesets {
    default_action                 = "Allow"
    trusted_service_access_enabled = var.trust_azure_services
    public_network_access_enabled  = false
  }
 
  public_network_access_enabled = false
 
  identity {
    type = "SystemAssigned"
  }
}
 
resource "azurerm_role_assignment" "event_hub_encryption_role" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_eventhub_namespace.this.identity[0].principal_id
}
 
resource "azurerm_eventhub_namespace_customer_managed_key" "nhns_cmk" {
  eventhub_namespace_id             = azurerm_eventhub_namespace.this.id
  key_vault_key_ids                 = [var.encryption_customer_managed_key]
 
  depends_on = [
    azurerm_role_assignment.event_hub_encryption_role
  ]
}
 
resource "azurerm_eventhub" "this" {
  message_retention   = var.message_retention
  name                = var.name
  namespace_name      = var.namespace_name
  partition_count     = var.partition_count
  resource_group_name = var.resource_group.name
 
  dynamic "capture_description" {
    for_each = [for i in [1] : i if var.storage_account_id != null && var.blob_container_name != null]
    content {
      enabled   = true
      encoding  = "Avro"
      destination {
        archive_name_format = var.capture_archive_name_format
        blob_container_name = var.blob_container_name
        name                = "EventHubArchive.AzureBlockBlob"
        storage_account_id  = var.storage_account_id
      }
    }
  }
}
 
resource "azurerm_eventhub_consumer_group" "consumer_group" {
  for_each            = toset(var.consumer_groups)
  eventhub_name       = azurerm_eventhub.this.name
  name                = each.key
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group.name
}