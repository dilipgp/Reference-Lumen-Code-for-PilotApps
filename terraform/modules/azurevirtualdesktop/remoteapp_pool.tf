// Create a Hostpool
resource "azurerm_virtual_desktop_host_pool" "remoteapphostpool" {
  location                 = var.metaregion
  resource_group_name      = var.resource_group_name
  name                     = join("-",["hp",var.country_code,"rap",var.sub_env,var.region_suffix,var.instance])
  validate_environment     = false
  custom_rdp_properties    = var.custom_rdp_properties
  type                     = "Pooled"
  start_vm_on_connect      = true
  maximum_sessions_allowed = var.sessions
  load_balancer_type       = "DepthFirst"
  preferred_app_group_type = "RailApplications"
  tags                     = var.tag_map
  lifecycle {
    ignore_changes = [load_balancer_type]
  }
}
 
 resource "azurerm_virtual_desktop_scaling_plan" "remoteapp" {
  name                = "sp-${azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].name}"
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  time_zone           = "Singapore Standard Time"
  tags                = var.tag_map
  schedule {
    name                                 = "Weekdays"
    days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    ramp_up_start_time                   = "08:00"
    ramp_up_load_balancing_algorithm     = "BreadthFirst"
    ramp_up_minimum_hosts_percent        = 20
    ramp_up_capacity_threshold_percent   = 60
    peak_start_time                      = "09:00"
    peak_load_balancing_algorithm        = "BreadthFirst"
    ramp_down_start_time                 = "18:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = 10
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 45
    ramp_down_notification_message       = "Please log off in the next 45 minutes..."
    ramp_down_capacity_threshold_percent = 90
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "20:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }
  host_pool {
    hostpool_id          = azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].id
    scaling_plan_enabled = true
  }
}
 
// Create a Application Group
resource "azurerm_virtual_desktop_application_group" "remoteappgroupmultisession" {
  name                = join("-",["dag","hp",var.country_code,"rap",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  type                = "RemoteApp"
  tags                = var.tag_map
  host_pool_id        = azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].id
depends_on = [
  azurerm_virtual_desktop_host_pool.remoteapphostpool
]
}
 
resource "azurerm_virtual_desktop_application" "publishedapp" {
  count                        = var.enable_remoteapp ? length(var.remoteapps) : 0
  name                         = var.remoteapps[count.index].name
  path                         = var.remoteapps[count.index].path
  command_line_argument_policy = var.remoteapps[count.index].command_line_argument_policy
  icon_path                    = var.remoteapps[count.index].icon_path
  #name                        = "textpad"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteappgroupmultisession[0].id
  #path                        = "c:\\program Files(x86)\\textpad 7\\textpad.exe"
  #command_line_argument_policy = "DoNotAllow"
  show_in_portal               = false
  #icon_path                    = "c:\\windows\\installer\\9F53AC20-2D32-4341-9DA1-29DD40E2199E\\newshortcut1.exe"
}
 
resource "azurerm_virtual_desktop_host_pool_registration_info" "remote_registration_info" {
  count           = var.enable_remoteapp ? 1 : 0
  hostpool_id     = azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].id
  expiration_date = var.expdate
}
 
// Create a Workspace
resource "azurerm_virtual_desktop_workspace" "rworkspace" {
  count               = var.enable_remoteapp ? 1 : 0
  name                = join("-",["ws","hp",var.country_code,"rap",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  tags                = var.tag_map
}
 
// Application Group Association
resource "azurerm_virtual_desktop_workspace_application_group_association" "appgroup_association_remoteapp" {
  count                = var.enable_remoteapp ? 1 : 0
  workspace_id         = azurerm_virtual_desktop_workspace.rworkspace[count.index].id
  application_group_id = azurerm_virtual_desktop_application_group.remoteappgroupmultisession[count.index].id
}
 
# diagnostics setting for remote hostpool
resource "azurerm_monitor_diagnostic_setting" "rhpmonitor" {
  count                          = var.enable_remoteapp ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_host_pool.remoteapphostpool[count.index].id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "AgentHealthStatus"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Checkpoint"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Connection"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Error"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "HostRegistration"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Management"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
 
  log {
    category = "NetworkData"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
 
  log {
    category = "SessionHostManagement"
    enabled  = true
 
    retention_policy {
       enabled = false
    }
  }
}
 
resource "azurerm_monitor_diagnostic_setting" "rdagmonitor" {
  count                          = var.enable_remoteapp ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_application_group.remoteappgroupmultisession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_application_group.remoteappgroupmultisession[count.index].id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "Checkpoint"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Error"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Management"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
}
 
resource "azurerm_monitor_diagnostic_setting" "rwsmonitor" {
  count                          = var.enable_remoteapp ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_workspace.rworkspace[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_workspace.rworkspace[count.index].id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "Checkpoint"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Error"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Management"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
}
 
resource "azurerm_monitor_diagnostic_setting" "remoteapp_diagnostic_setting" {
  count                          = var.enable_remoteapp ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_scaling_plan.remoteapp[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_scaling_plan.remoteapp[count.index].id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "Autoscale"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
}