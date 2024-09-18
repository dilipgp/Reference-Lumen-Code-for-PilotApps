resource "azurerm_private_endpoint" "ep" {
    name                        = "pe-${azurerm_eventhub_namespace.this.name}"
    location                    = var.resource_group.location
    resource_group_name         = var.resource_group.name
 
    tags                        = var.tag_map
    subnet_id                   = var.private_endpoint_subnet_id
 
#    private_dns_zone_group {
#        name                    = format("%s-eventhub-namespace-private-dns-zone-group", lower(azurerm_eventhub_namespace.this.name))
#        private_dns_zone_ids    = [var.private_dns_zone_namespace_id]
#    }
 
    private_service_connection {
        name                           = azurerm_eventhub_namespace.this.name
        is_manual_connection           = false
        private_connection_resource_id = azurerm_eventhub_namespace.this.id
        subresource_names              = ["namespace"]
    }
}