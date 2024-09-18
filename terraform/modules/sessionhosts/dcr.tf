/*
resource "azurerm_monitor_data_collection_rule_association" "dcr_rule_association" {
 
  count                   = var.enable_ama_extension ? var.vm_count : 0
  name                    = "vm${count.index}-rule-association"
  target_resource_id      = azurerm_windows_virtual_machine.vm[count.index].id
  data_collection_rule_id = var.dcr_id
  description             = "vm collection rule"
}*/