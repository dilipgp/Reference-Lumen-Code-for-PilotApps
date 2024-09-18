# create azure log analytics workspace
resource "azurerm_log_analytics_workspace" "workspace" {
  # Mandatory resource attributes
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  local_authentication_disabled = true
}





# data export
resource "azurerm_log_analytics_data_export_rule" "export_rule" {
  count                   = length(var.data_export_rule)
  name                    = var.data_export_rule[count.index].name
  resource_group_name     = var.resource_group_name
  workspace_resource_id   = azurerm_log_analytics_workspace.workspace.id
  destination_resource_id = var.data_export_rule[count.index].destination_resource_id
  table_names             = var.data_export_rule[count.index].table_names
  enabled                 = var.data_export_rule[count.index].enabled
}