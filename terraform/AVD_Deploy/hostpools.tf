module "host_pools_in" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_in
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.privte_endpoint_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_medium
  sku                     = var.sku_medium
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = false
  enable_remoteapp        = false
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_in_light" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_in
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_light
  sku                     = var.sku_light
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = var.enable_singlesession
  enable_remoteapp        = var.enable_remoteapp
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_in_heavy" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_in
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_heavy
  sku                     = var.sku_heavy
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = var.enable_singlesession
  enable_remoteapp        = false
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_my" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_my
  metaregion              = var.metaregion
  tag_map                 = var.tags
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_medium
  sku                     = var.sku_medium
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = var.enable_singlesession
  enable_remoteapp        = false
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_my_light" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_my
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_light
  sku                     = var.sku_light
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = false
  enable_remoteapp        = var.enable_remoteapp
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_my_heavy" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_my
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_heavy
  sku                     = var.sku_heavy
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = false
  enable_remoteapp        = false
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
module "host_pools_sg" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_sg
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.privte_endpoint_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_medium
  sku                     = var.sku_medium
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = var.enable_singlesession
  enable_remoteapp        = var.enable_remoteapp
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}
 
module "host_pools_hk" {
  source                  = "../modules/azurevirtualdesktop"
  app_name                = var.app_name
  region                  = var.region
  environment             = var.environment
  sub_env                 = var.environment_subtype
  country_code            = var.country_code_hk
  metaregion              = var.metaregion
  tag_map                 = var.tags  
  subnet_id               = data.azurerm_subnet.session_host_sub.id
  region_suffix           = var.regionsuffix
  instance                = "001"
  sessions                = var.sessions_medium
  sku                     = var.sku_medium
  expdate                 = var.expdate
  enable_multisession     = var.enable_multisession
  enable_singlesession    = var.enable_singlesession
  enable_remoteapp        = var.enable_remoteapp
  resource_group_name     = azurerm_resource_group.rg.name
  log_analytics_workspace = module.log-analytics-workspace.laws_workspace_id
#Storage account arguments
  resource_group          = azurerm_resource_group.rg
  keyvault                = module.key_vault.keyvault_id
  enable_storage          = false
}