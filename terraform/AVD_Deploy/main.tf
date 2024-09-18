data "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.app_name}-${var.env_short_name}-${var.location_short}-001"
  resource_group_name = "rg-${var.app_name}-${var.vnet_rg_key}-${var.environment_subtype}-${var.location_short}-001"
}
 
data "azurerm_subnet" "privte_endpoint_sub" {
  name                 = "snet-${var.app_name}-pe-${var.env_short_name}-${var.location_short}-001"
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
 
data "azurerm_subnet" "session_host_sub" {
  name                 = "snet-${var.app_name}-sh-${var.env_short_name}-${var.location_short}-001"
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
 
module "fsilogix_fileshare"{
    source                     = "../modules/FsiLogixFS"
    subnet_id                  = data.azurerm_subnet.privte_endpoint_sub.id
    resource_group_name        = data.azurerm_resource_group.rg.name
    region                     = var.region
    region_suffix              = var.regionsuffix
    environment                = var.environment_subtype
    enable_storage             = var.enable_storage
    keyvault                   = "/subscriptions/a1895833-f64d-46eb-a05b-bfd1a641f2e7/resourceGroups/infra-eastasia-rg/providers/Microsoft.KeyVault/vaults/kv-clouddesktopeng1"
}

module "msix_fileshare"{
    source                     = "../modules/MsixFS"
    subnet_id                  = data.azurerm_subnet.privte_endpoint_sub.id
    resource_group_name        = data.azurerm_resource_group.rg.name
    region                     = var.region
    region_suffix              = var.regionsuffix
    environment                = var.environment_subtype
    enable_storage             = var.enable_storage
    keyvault                   = "/subscriptions/a1895833-f64d-46eb-a05b-bfd1a641f2e7/resourceGroups/infra-eastasia-rg/providers/Microsoft.KeyVault/vaults/kv-clouddesktopeng1"
}

module "vnet" {
  source                       = "../modules/vnet"
  rg_name                      = azurerm_resource_group.rg.name
  rg_location                  = var.region
  app_name                     = var.app_name
  environment                  = var.environment
  env_short_name               = var.env_short_name
  location_short               = var.location_short
  tags                         = var.tags
  use_existing_network_watcher = var.use_existing_network_watcher
  vnet_config                  = var.vnet_config
  spoke_vnet_peering_enable    = var.spoke_vnet_peering_enable
}
 
 
module "log-analytics-workspace" {
  source              = "../modules/laws"
  location            = var.region
  name                = "law-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
  resource_group_name = azurerm_resource_group.rg.name
}
 
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.app_name}-app-${var.environment_subtype}-${var.location_short}-001"
  location =  var.region
  tags     = var.tags
}
 
module "key_vault" {
  source                          = "../modules/keyvault"
  app_name                        = var.app_name
  region                          = var.region
  resource_group                  = azurerm_resource_group.rg.name
  environment                     = var.environment
  env_short_name                  = var.env_short_name
  location_short                  = var.location_short
  kv_instance                     = var.kv_instance
  keyvault_admin_ids              = local.admin_aad_object_ids
  keyvault_key_writer_ids         = local.key_writer_aad_object_ids
  keyvault_secret_writer_ids      = local.secret_writer_aad_object_ids
  keyvault_certificate_writer_ids = local.certificate_writer_aad_object_ids
  keyvault_reader_ids             = local.reader_aad_object_ids
  keyvault_secert_reader_ids      = local.secret_reader_aad_object_ids
  private_endpoint_subnet_id      = [data.azurerm_subnet.session_host_sub.id]
  azure_resource_lock_enable      = var.azure_resource_lock_enable
  whitelist_ips                   = var.whitelist_ips
  log_analytics_workspace         = module.log-analytics-workspace.laws_workspace_id
  tag_map                         = var.tags
}
 
/*
module "event_hub_namespace" {
  source                          = "../modules/eventhubns"
  resource_group                  = azurerm_resource_group.rg
  namespace_name                  = "evhn-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
  encryption_customer_managed_key = "https://kv-img-stg-sea-001.vault.azure.net/keys/test-key-001/b01561188d414782af99bb877039e375"
  key_vault_id                    = "/subscriptions/cd8b5e40-c586-40ad-a1e0-0f86ce70c9b0/resourceGroups/rg-cds-img-stg-sea-001/providers/Microsoft.KeyVault/vaults/kv-img-stg-sea-001"
  tag_map                         = var.tags
  private_endpoint_subnet_id      = data.azurerm_subnet.privte_endpoint_sub.id
  name                            = "evh-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
}
*/
module "data_collection_rule" {
  source                          = "../modules/dcr"
  resource_group                  = azurerm_resource_group.rg.name
  dcr_name                        = "dcr-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
  region                          = var.region
  laws_id                         = module.log-analytics-workspace.laws_workspace_id
  tag_map                         = var.tags
}
 
module "alert_config" {
  source                      = "../modules/alerts"
  action_group_name           = "ag-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
  alert_config_name           = "ar-${var.app_name}-${var.env_short_name}-${var.regionsuffix}-001"
  resource_group              = azurerm_resource_group.rg.name
  sa_1                        = module.fsilogix_fileshare.storage_account.name
  sa_2                        = module.fsilogix_fileshare.storage_account.name
  tagvalue                    = var.tags
  region                      = var.region
}
 
module "sa_kvkey" {
  source                      = "../modules/keyvaultobjects"
  key_vault_id                = module.key_vault.keyvault_id
  key_name                    = "key-cds-stcmk-001"
  key_tagvalue                = var.tags
}
 
module "image_gallery" {
  source                      = "../modules/imagegallery"
  enable_gallery              = true
  environment                 = var.environment
  gallery_name                = "acg_${var.app_name}_${var.env_short_name}_001"
  resource_group              = "rg-${var.app_name}-img-${var.environment_subtype}-${var.location_short}-001"
  region                      = var.region
  definition_name_ms          = "win10-ms"
  definition_name_ss          = "win10-ss"
  tags                        = var.tags
}

resource "null_resource" "win_msix_custom_script" {
  provisioner "local-exec" {
    command = "${file("${path.module}/scripts/MSIXpackage.ps1")} -packageaction "ADDMSIX" -SubscriptionName "MCAPS-Hybrid-REQ-62980-2023-ragu" -HostPoolName "hp-hk-msm-stg-sea-001" -ResourceGroupName \"clouddesktop-eastasia-rg\" -ImageUNCPath "\\stcdssmsixappstgsea001.file.core.windows.net\\MSIXAPPATTACH" -DisplayName "WINSCP"
    #command = "Get-Date"
    #interpreter = ["PowerShell", "-File"]
    #interpreter = ["pwsh", "-Command"]
    }
}