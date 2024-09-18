output "namespace_resource_id" {
  depends_on = [
    azurerm_eventhub_namespace_customer_managed_key.nhns_cmk,
    azurerm_private_endpoint.ep
  ]
  value = azurerm_eventhub_namespace.this.id
}