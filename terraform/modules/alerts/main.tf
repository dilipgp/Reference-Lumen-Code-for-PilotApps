resource "azurerm_monitor_action_group" "main" {
name                = var.action_group_name
resource_group_name = var.resource_group
short_name          = "p0"
email_receiver {
    name          = "ravinder"
    email_address = "ravinder.gupta@sc.com"
  }
sms_receiver {
    name         = "ravinderg"
    country_code = "91"
    phone_number = "9999349414"
  }
tags = var.tagvalue
}
 
resource "azurerm_monitor_metric_alert" "main" {
name                     = var.alert_config_name
resource_group_name      = var.resource_group
scopes                   = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}"]
target_resource_type     = "Microsoft.Compute/virtualMachines"
target_resource_location = var.region
description              = "Action will be triggered when Percentage CPU is greater than 75."
severity                 = 3
criteria {
  metric_namespace = "Microsoft.Compute/virtualMachines"
  metric_name      = "Percentage CPU"
  aggregation      = "Average"
  operator         = "GreaterThan"
  threshold        = 75
}
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
 
resource "azurerm_monitor_metric_alert" "memory5" {
name                      = "Low Memory Alert 5 GB"
resource_group_name       = var.resource_group
scopes                    = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}"]
target_resource_type      = "Microsoft.Compute/virtualMachines"
target_resource_location  = var.region
description               = "Action will be triggered when Average Memory is less than about 5 GB."
severity                  = 2
criteria {
  metric_namespace  = "Microsoft.Compute/virtualMachines"
  metric_name       = "Available Memory Bytes"
  aggregation       = "Average"
  operator          = "LessThan"
  threshold         = 5000000000
}
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
 
resource "azurerm_monitor_metric_alert" "memory2" {
name                      = "Low Memory Alert 2 GB"
resource_group_name       = var.resource_group
scopes                    = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}"]
target_resource_type      = "Microsoft.Compute/virtualMachines"
target_resource_location  = var.region
description               = "Action will be triggered when Average Memory is less than about 2 GB."
severity                  = 1
criteria {
  metric_namespace  = "Microsoft.Compute/virtualMachines"
  metric_name       = "Available Memory Bytes"
  aggregation       = "Average"
  operator          = "LessThan"
  threshold         = 2000000000
}
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
 
resource "azurerm_monitor_metric_alert" "sa1_70" {
name                = "fs-70-alert-01"
resource_group_name = var.resource_group
scopes = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}/providers/Microsoft.Storage/storageAccounts/${var.sa_1}/fileservices/default"]
target_resource_type = "Microsoft.Storage/storageAccounts/fileservices"
target_resource_location = var.region
description         = "Action will be triggered when Average File Share available is less than 30%"
severity            = 3
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts/fileServices"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 30
  }
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
resource "azurerm_monitor_metric_alert" "sa1_80" {
name                = "fs-80-alert-01"
resource_group_name = var.resource_group
scopes = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}/providers/Microsoft.Storage/storageAccounts/${var.sa_1}/fileservices/default"]
target_resource_type = "Microsoft.Storage/storageAccounts/fileservices"
target_resource_location = var.region
description         = "Action will be triggered when Average File Share available is less than 20%"
severity            = 2
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts/fileServices"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 20
  }
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
 
resource "azurerm_monitor_metric_alert" "sa2_70" {
count               = var.sa_2 != null ? 1 : 0
name                = "fs-70-alert-02"
resource_group_name = var.resource_group
scopes = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}/providers/Microsoft.Storage/storageAccounts/${var.sa_2}/fileservices/default"]
target_resource_type = "Microsoft.Storage/storageAccounts/fileservices"
target_resource_location = var.region
description         = "Action will be triggered when Average File Share available is less than 30%"
severity            = 3
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts/fileServices"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 30
  }
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}
resource "azurerm_monitor_metric_alert" "sa2_80" {
count               = var.sa_2 != null ? 1 : 0
name                = "fs-80-alert-02"
resource_group_name = var.resource_group
scopes = ["${data.azurerm_subscription.current.id}/resourceGroups/${var.resource_group}/providers/Microsoft.Storage/storageAccounts/${var.sa_2}/fileservices/default"]
target_resource_type = "Microsoft.Storage/storageAccounts/fileservices"
target_resource_location = var.region
description         = "Action will be triggered when Average File Share available is less than 20%"
severity            = 2
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts/fileServices"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 20
  }
action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
tags = var.tagvalue
}