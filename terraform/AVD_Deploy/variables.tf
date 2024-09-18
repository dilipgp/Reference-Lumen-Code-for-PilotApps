# Variable declaration for Region
variable "region" {
  description = "The region of deployment"
}
 
# Variable declaration for app_name
variable "app_name" {
  description = "The app_name name to be provided"
}
 
variable "environment" {
  description = "Environment classification: development|testing|staging|production"
}
variable "environment_subtype" {}
 
variable "owner_users" {
  type    = list(string)
  default = []
}
 
variable "owner_groups" {
  type    = list(string)
  default = []
}
 
variable "tags" {
  type    = map(string)
  default = {}
}
 
#variable "trigger_by" {
#}
 
variable "metaregion" {}
variable "sessions_light" {}
variable "sessions_medium" {}
variable "sessions_heavy" {}
variable "sku_light" {}
variable "sku_medium" {}
variable "sku_heavy" {}
variable "expdate" {}
 
variable "enable_singlesession" {
    description = "Enable/disable singlesession hostpool"
    type        = bool
}
 
variable "enable_multisession" {
    description = "Enable/disable multisession hostpool"
    type        = bool
}
 
variable "workspace_location" {
  description = "Workspace Location name"
  default = ""
}
variable "enable_remoteapp" {
    description = "Enable/disable remoteapp hostpool"
    type        = bool
}
 
variable "use_existing_network_watcher" {
  type = bool
}
 
variable "enable_backup" {}
variable "storage_account_create" {}
variable "regionsuffix" {}
variable "country_code_in" {}
variable "country_code_sg" {}
variable "country_code_hk" {}
variable "multivm_count_sg" {}
variable "multivm_count_in" {}
variable "multivm_count_hk" {}
variable "country_code_my" {}
variable "mvm_image_id" {}
variable "multivm_name_in" {}
variable "multivm_light_my" {}
variable "multivm_medium_my" {}
variable "multivm_heavy_my" {}
variable "remoteappvm_my" {}
variable "domainjoin" {}
variable "ms_OUPath" {}
variable "ss_OUPath" {}
variable "mgmt_OUPath" {}
variable "wvddsc_enable"{}
variable "multivm_name_sg" {}
variable "multivm_name_hk" {}
variable "packagingvm_name_hk" {}
variable "singlevm_count" {}
variable "svm_image_id" {}
variable "singlevm_name_in" {}
variable "singlevm_name_sg" {}
variable "singlevm_light_my" {}
variable "singlevm_medium_my" {}
variable "singlevm_heavy_my" {}
variable "single_size" {}
variable "multi_size" {}
variable "vnet_rg_key" {}
variable "kv_instance" {}
variable "rg_name" {
}
variable "key_name" {
}
variable "vnet_rg_name" {
}
 
variable "env_short_name" {
  type = string
}
 
variable "location_short" {
  type = string
}
 
#variable admin_users is the list of users who must have access (read, write, update) to the KeyVault's Keys, secrets and certificates. Example "o.azure.####@zone1.scb.net"
variable "admin_users" {
  type = list(string)
}
 
#variable admin_groups is the list of AD group/s who must have access (read, write, update) to the KeyVault's Keys, secrets and certificates.
variable "admin_groups" {
  type = list(string)
}
 
#variable admin_users is the list of users who must have access (read, write, update) to the KeyVault's Keys. Example "o.azure.####@zone1.scb.net"
variable "key_writer_users" {
  type    = list(string)
  default = []
}
 
#variable admin_groups is the list of AD group/s who must have access (read, write, update) to the KeyVault's Keys.
variable "key_writer_groups" {
  type    = list(string)
  default = []
}
 
#variable admin_users is the list of users who must have access (read, write, update) to the KeyVault's secrets. Example "o.azure.####@zone1.scb.net"
variable "secret_writer_users" {
  type    = list(string)
  default = []
}
 
#variable admin_groups is the list of AD group/s who must have access (read, write, update) to the KeyVault's secrets.
variable "secret_writer_groups" {
  type    = list(string)
  default = []
}
 
#variable admin_users is the list of users who must have access (read, write, update) to the KeyVault's certificates. Example "o.azure.####@zone1.scb.net"
variable "certificate_writer_users" {
  type    = list(string)
  default = []
}
 
#variable admin_groups is the list of AD group/s who must have access (read, write, update) to the KeyVault's certificates.
variable "certificate_writer_groups" {
  type    = list(string)
  default = []
}
 
#variable admin_users is the list of users who must have access (read) to the KeyVault's Keys, secrets and certificates. Can't get secret value. Example "o.azure.####@zone1.scb.net"
variable "reader_users" {
  type    = list(string)
  default = []
}
 
#variable admin_groups is the list of AD group/s who must have access (read) to the KeyVault's Keys, secrets and certificates. Can't get secret value.
variable "reader_groups" {
  type    = list(string)
  default = []
}
 
#variable admin_users is the list of users who must have access (read) to the KeyVault's secrets. Example "o.azure.####@zone1.scb.net"
variable "secret_reader_users" {
  type    = list(string)
  default = []
}
 
#variable admin_groups is the list of AD group/s who must have access (read) to the KeyVault's secrets.
variable "secret_reader_groups" {
  type    = list(string)
  default = []
}
 
# Variable declaration for Azure Resource Lock
variable "azure_resource_lock_enable" {
  type = bool
}
 
# Variable declaration for Whitelist IPs
variable "whitelist_ips" {
  type = list(string)
}
 
variable "key_vault_key_creation" {
  type = bool
}
 
variable "admin_username" {
  default = "scbadmin"
}
 
variable "vnet_config" {
  description = "VNet configuration"
}
 
variable "spoke_vnet_peering_enable" {
  type = bool
}
 
variable "enable_ama_extension" {}

variable "enable_storage" {}