resource "azurerm_monitor_diagnostic_setting" "key_vault_diagnostic_setting" {
  name                           = "AzureKeyVaultDiagnosticsLogsToWorkspace"
  target_resource_id             = azurerm_key_vault.key_vault.id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "AuditEvent"
    enabled  = true
  }
 
  metric {
    category = "AllMetrics"
    enabled  = true
  }
 
  lifecycle {
    ignore_changes = [log]
  }
}