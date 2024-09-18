output "vnet" {
  value = azurerm_virtual_network.vnet
}
 
output "subnet" {
  value = {
    for id in keys(var.vnet_config["subnets"]) : id => azurerm_subnet.subnet[id].id
  }
}