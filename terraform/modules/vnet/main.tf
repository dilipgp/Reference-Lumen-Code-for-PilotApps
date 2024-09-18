//vnet
data "azurerm_subscription" "current" {}
 
 
 
resource "azurerm_virtual_network" "vnet" {
  address_space       = var.vnet_config["vpc_cidr_list"]
  location            = var.rg_location
  name                = "vnet-${var.app_name}-${var.env_short_name}-${var.location_short}-001"
  resource_group_name = var.rg_name
  dns_servers         = lookup(var.vnet_config, "dns_servers", [])
  tags                = merge(var.tags, { tier = "spoke" })
}
 
 
//subnets
resource "azurerm_subnet" "subnet" {
  for_each = var.vnet_config["subnets"]
  address_prefixes     = each.value["subnet_list"]
  name                 = "snet-${var.app_name}-${each.value["index"]}-${var.env_short_name}-${var.location_short}-001"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = contains(keys(each.value),"service_endpoints") ? each.value["service_endpoints"] : null
  private_endpoint_network_policies_enabled = contains(keys(each.value),"private_endpoint_network_policies_enabled") ? each.value["private_endpoint_network_policies_enabled"] : true
  private_link_service_network_policies_enabled = contains(keys(each.value),"private_link_service_network_policies_enabled") ? each.value["private_link_service_network_policies_enabled"] : true
}