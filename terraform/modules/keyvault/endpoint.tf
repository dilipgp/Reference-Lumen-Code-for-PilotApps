locals {
  _tnd_tenant_id = "cd823f6b-31c5-4241-b504-3707cbc03fb7"
  ep_zone_rg_id = data.azurerm_subscription.current.tenant_id == local._tnd_tenant_id ? "/subscriptions/0f6d33c6-8851-4389-a1a7-42b00e012839/resourceGroups/development-private-ep-zones" : "/subscriptions/6a08fa5c-22b9-47f2-8af1-5ceeb68cced3/resourceGroups/production-private-ep-zones"
}
 
resource "azurerm_private_endpoint" "ep" {
  name                = format("%s-keyvault-private-link-ep", lower(azurerm_key_vault.key_vault.name))
  location            = var.region
  resource_group_name = var.resource_group
  subnet_id           = var.private_endpoint_subnet_id[0]
  private_dns_zone_group {
    name = format("%s-keyvault-private-dns-zone-group", lower(azurerm_key_vault.key_vault.name))
    private_dns_zone_ids = [
      format("%s/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net", local.ep_zone_rg_id)
    ]
  }
  private_service_connection {
    name                           = format("%s-keyvault-private-link-svc-conf", lower(azurerm_key_vault.key_vault.name))
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    subresource_names              = ["Vault"]
  }
}