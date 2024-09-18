// Create a Hostpool
resource "azurerm_virtual_desktop_host_pool" "hostpoolsinglesession" {
  count                    = var.enable_singlesession ? 1 : 0
  location                 = var.metaregion
  resource_group_name      = var.resource_group_name
  name                     = join("-",["hp",var.country_code,"ss${var.sku}",var.sub_env,var.region_suffix,var.instance])
  validate_environment     = false
  custom_rdp_properties    = var.custom_rdp_properties
  type                     = "Personal"
  start_vm_on_connect      = true
  personal_desktop_assignment_type = "Automatic"
  load_balancer_type       = "Persistent"
  tags                     = var.tag_map
}
 
// Create a Application Group
resource "azurerm_virtual_desktop_application_group" "appgroupsinglesession" {
  count               = var.enable_singlesession ? 1 : 0
  name                = join("-",["dag","hp",var.country_code,"ss${var.sku}",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  type                = "Desktop"
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].id
  tags                = var.tag_map
depends_on = [
  azurerm_virtual_desktop_host_pool.hostpoolsinglesession
]
}
 
resource "azurerm_virtual_desktop_host_pool_registration_info" "single_registration_info" {
  count           = var.enable_singlesession ? 1 : 0
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].id
  expiration_date = var.expdate
}
 
#workspace for single session pool
resource "azurerm_virtual_desktop_workspace" "pworkspace" {
  count               = var.enable_singlesession ? 1 : 0
  name                =  join("-",["ws","hp",var.country_code,"ss${var.sku}",var.sub_env,var.region_suffix,var.instance])
  location            = var.metaregion
  resource_group_name = var.resource_group_name
  tags                = var.tag_map
}
 
// Personal pool Application Group Association with Workspace
resource "azurerm_virtual_desktop_workspace_application_group_association" "appgroup_association_singlesession" {
  count                = var.enable_singlesession ? 1 : 0
  workspace_id         = azurerm_virtual_desktop_workspace.pworkspace[count.index].id
  application_group_id = azurerm_virtual_desktop_application_group.appgroupsinglesession[count.index].id
}
 
resource "azurerm_private_endpoint" "singlesession" {
  count                         = var.enable_singlesession ? 1 : 0
  name                          = "pe-${azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].name}"
  location                      = var.region
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pe-${azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].name}"
  private_dns_zone_group {
    name = format("%s-hostpool-private-dns-zone-group", lower(azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].name))
    private_dns_zone_ids = [
      format("%s/providers/Microsoft.Network/privateDnsZones/privatelink.wvd.microsoft.com", local.ep_zone_rg_id)
    ]
  }
  private_service_connection {
    name                           = azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].name
    private_connection_resource_id = azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].id
    is_manual_connection           = false
    subresource_names              = ["connection"]
  }
}
# diagnostics setting for remote hostpool
resource "azurerm_monitor_diagnostic_setting" "sshpmonitor" {
  count                          = var.enable_singlesession ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_host_pool.hostpoolsinglesession[count.index].id
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
 
resource "azurerm_monitor_diagnostic_setting" "ssdagmonitor" {
  count                          = var.enable_singlesession ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_application_group.appgroupsinglesession[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_application_group.appgroupsinglesession[count.index].id
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
 
resource "azurerm_monitor_diagnostic_setting" "sswsmonitor" {
  count                          = var.enable_singlesession ? 1 : 0
  name                           = join("-",["${azurerm_virtual_desktop_workspace.pworkspace[count.index].name}","monitor"])
  target_resource_id             = azurerm_virtual_desktop_workspace.pworkspace[count.index].id
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