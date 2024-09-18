resource "azurerm_virtual_machine_extension" "ama_extension" {
 
  count = var.enable_ama_extension ? var.vm_count : 0
 
  name                      = "AzureMonitorWindowsAgent"
  virtual_machine_id        = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                 = "Microsoft.Azure.Monitor"
  type                      = "AzureMonitorWindowsAgent"
  type_handler_version      = "1.18"
  automatic_upgrade_enabled = true
}