locals {
  hostpoolsinglesession_id  = var.enable_singlesession ? azurerm_virtual_desktop_host_pool.hostpoolsinglesession.id : ""
  single_registration_token = var.enable_singlesession ? azurerm_virtual_desktop_host_pool_registration_info.single_registration_info.token : ""
  hostpoolmultisession_id    = var.enable_multisession ? azurerm_virtual_desktop_host_pool.hostpoolmultisession.id : ""
  multi_registration_info   = var.enable_multisession ? azurerm_virtual_desktop_host_pool_registration_info.multi_registration_info.token : ""
  remoteapphostpool_id       = var.enable_remoteapp ? azurerm_virtual_desktop_host_pool.remoteapphostpool.id : ""
  remote_registration_info  = var.enable_remoteapp ? azurerm_virtual_desktop_host_pool_registration_info.remote_registration_info.token : ""
  pworkspace_id              = var.enable_workspace ? azurerm_virtual_desktop_workspace.pworkspace.id : ""
  mworkspace_id              = var.enable_workspace ? azurerm_virtual_desktop_workspace.mworkspace.id : ""
  rworkspace_id              = var.enable_workspace ? azurerm_virtual_desktop_workspace.rworkspace.id : ""
}
 
locals {
  _zrs_supported_regions = ["uksouth", "southeastasia"]
  account_replication_type = var.account_replication_type == "ZRS" ? (
    // ZRS if not support fall back to GRS
    contains(local._zrs_supported_regions, var.resource_group.location) ? "ZRS" : "GRS"
  ) : var.account_replication_type
 
  // convert input storage account to a valid storage account name,
  // max 24 characters in length and may contain numbers and lowercase letters only.
  _clean_storage_account_name = join("", regexall("[a-z0-9]", lower(var.storage_account_name)))
  storage_account_name        = substr(local._clean_storage_account_name, 0, min(24, length(local._clean_storage_account_name)))
 
  versioning_enabled              = var.is_hns_enabled ? false : (var.enable_backup ? true : var.enable_versioning)
  container_delete_retention_days = var.enable_backup ? 365 : var.container_delete_retention_days
  blob_delete_retention_days      = var.enable_backup ? 365 : var.delete_retention_days
  change_feed_enabled             = var.is_hns_enabled ? false : (var.enable_backup ? true : false)
  tagvalue                        = var.enable_backup ? merge(var.tagvalue, tomap({ "backup_enabled" = "true" })) : var.tagvalue
  share_delete_retention_days     = var.enable_backup ? 365 : var.share_delete_retention_days
}
 
locals {
  _dev_subscription_id = "612cc3a6-050e-4e10-ae53-4f08cff8029b"
  ep_zone_rg_id = data.azurerm_subscription.current.id == local._dev_subscription_id ? "/subscriptions/92bed8ec-9361-4dd5-8cf9-d1a8edf0a756/resourceGroups/corp-dev-global-rg-dns-zones" : "/subscriptions/dab2f930-9af1-47f3-97d9-dca9ae9deef2/resourceGroups/corp-prod-global-rg-dns-zones"
}
##Locals
locals {
  // Refer to below for the latest list
  //  https://confluence.global.standardchartered.com/display/ISOAWS/Cloud+Networks#CloudNetworks-ZscalerPublicIPAddress:
  // https://confluence.global.standardchartered.com/display/SWBS/Zscaler+IP+ranges+-+reference
  scb_proxy_ext_cidr = [
    "52.172.151.0",
    "20.187.78.37",
    "40.83.95.101",
    "20.198.148.189",
    "20.49.219.88",
    "52.172.175.23",
    "40.83.97.217",
    "20.197.65.216",
    "20.49.136.74",
    "104.129.194.0/23",
    "136.226.228.0/23",
    "136.226.230.0/23",
    "136.226.232.0/23",
    "136.226.234.0/23",
    "136.226.236.0/23",
    "136.226.238.0/23",
    "136.226.240.0/23",
    "136.226.242.0/23",
    "136.226.244.0/23",
    "136.226.250.0/23",
    "136.226.252.0/23",
    "136.226.254.0/23",
    "136.226.48.0/23",
    "136.226.50.0/23",
    "136.226.52.0/23",
    "136.226.62.0/23",
    "136.226.80.0/23",
    "136.226.90.0/23",
    "147.161.128.0/23",
    "147.161.160.0/23",
    "147.161.162.0/23",
    "147.161.164.0/23",
    "147.161.166.0/23",
    "147.161.174.0/23",
    "147.161.188.0/23",
    "147.161.198.0/23",
    "147.161.224.0/23",
    "147.161.234.0/23",
    "147.161.236.0/23",
    "147.161.248.0/23",
    "165.225.102.0/24",
    "165.225.104.0/24",
    "165.225.106.0/23",
    "165.225.110.0/23",
    "165.225.112.0/23",
    "165.225.116.0/23",
    "165.225.120.0/23",
    "165.225.122.0/23",
    "165.225.124.0/23",
    "165.225.16.0/23",
    "165.225.192.0/23",
    "165.225.196.0/23",
    "165.225.198.0/23",
    "165.225.206.0/23",
    "165.225.220.0/23",
    "165.225.230.0/23",
    "165.225.234.0/23",
    "165.225.26.0/23",
    "165.225.38.0/23",
    "165.225.72.0/22",
    "165.225.8.0/23",
    "165.225.80.0/22",
    "165.225.90.0/23",
    "165.225.96.0/23",
    "176.98.33.103",
    "176.98.33.107",
    "197.98.201.0/24",
    "210.13.127.39",
    "210.13.127.43",
    "213.42.116.42",
    "213.42.116.46",
    "58.33.27.183",
    "58.33.27.187",
    "93.112.33.167",
    "93.112.33.171",
    "94.56.213.180",
    "94.56.213.185",
  ]
}