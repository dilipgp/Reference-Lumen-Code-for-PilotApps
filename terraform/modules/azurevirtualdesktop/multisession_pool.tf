// Create a multisession Hostpool
resource "azurerm_virtual_desktop_host_pool" "hostpoolmultisession" {
  location                 = var.metaregion
  resource_group_name      = var.resource_group_name
  name                     = join("-",["hp",var.country_code,"ms${var.sku}",var.sub_env,var.region_suffix,var.instance])
  validate_environment     = false
  custom_rdp_properties    = var.custom_rdp_properties
  type                     = "Pooled"
  start_vm_on_connect      = true
  maximum_sessions_allowed = var.sessions
  load_balancer_type       = var.MS_load_balancer_type
  tags                     = var.tag_map
  lifecycle {
    ignore_changes = [load_balancer_type]
  }
}
 
resource "azurerm_virtual_desktop_scaling_plan" "multisession" {

  name                = "sp-${azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name}"
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
    hostpool_id          = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].id
    scaling_plan_enabled = false
  }
}
 
 
// Create a multisession Application Group
resource "azurerm_virtual_desktop_application_group" "appgroupmultisession" {
  name                = join("-",["dag","hp",var.country_code,"ms${var.sku}",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  type                = "Desktop"
  tags                = var.tag_map
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].id
  depends_on = [
    azurerm_virtual_desktop_host_pool.hostpoolmultisession
  ]
}
resource "azurerm_virtual_desktop_host_pool_registration_info" "multi_registration_info" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].id
  expiration_date = var.expdate
}
 
// Create a Workspace
resource "azurerm_virtual_desktop_workspace" "mworkspace" {
  name                = join("-",["ws","hp",var.country_code,"ms${var.sku}",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  tags                = var.tag_map
}
 
// Application Group Association
resource "azurerm_virtual_desktop_workspace_application_group_association" "appgroup_association_multisession" {
  workspace_id         = azurerm_virtual_desktop_workspace.mworkspace[count.index].id
  application_group_id = azurerm_virtual_desktop_application_group.appgroupmultisession[count.index].id
}
// Create Private Endpoint for Multisession Host Pool
resource "azurerm_private_endpoint" "multisession" {
  name                          = "pe-${azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name}"
  location                      = var.region
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pe-${azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name}"
  tags                          = var.tag_map
  private_dns_zone_group {
    name = format("%s-hostpool-private-dns-zone-group", lower(azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name))
    private_dns_zone_ids = [
      format("%s/providers/Microsoft.Network/privateDnsZones/privatelink.wvd.microsoft.com", local.ep_zone_rg_id)
    ]
  }
  private_service_connection {
    name                           = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name
    private_connection_resource_id = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].id
    is_manual_connection           = false
    subresource_names              = ["connection"]
  }
}
 
# diagnostics setting for remote hostpool
resource "azurerm_monitor_diagnostic_setting" "mshpmonitor" {
  name                           = join("-",["${azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_host_pool.hostpoolmultisession[count.index].id
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
 
# diagnostics setting for remote hostpool
resource "azurerm_monitor_diagnostic_setting" "msdagmonitor" {
  name                           = join("-",["${azurerm_virtual_desktop_application_group.appgroupmultisession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_application_group.appgroupmultisession[count.index].id
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
 
resource "azurerm_monitor_diagnostic_setting" "mswsmonitor" {
  name                           = join("-",["${azurerm_virtual_desktop_workspace.mworkspace[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_workspace.mworkspace[count.index].id
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
 
resource "azurerm_monitor_diagnostic_setting" "scaling_plan_diagnostic_setting" {
  name                           = join("-",["${azurerm_virtual_desktop_scaling_plan.multisession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_scaling_plan.multisession[count.index].id
  log_analytics_workspace_id     = var.log_analytics_workspace
 
  log {
    category = "Autoscale"
    enabled  = true
 
    retention_policy {
      enabled = false
    }
  }
}