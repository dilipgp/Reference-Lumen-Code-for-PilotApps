# Variable declaration for app_name
variable "app_name" {}
 
variable "region"{
     description = "region"
     type        = string
}
 
variable "region_suffix" {}
 
variable "sessions"{
    description = "Max sessions per hostpool"
    type        =  number
    default     = 1
}
 
variable "expdate"{
    description = "HP Registration Key"
    type        =  string
}
 
variable "sku" {}
variable "environment" {
  description = "Environment classification: development / staging / production"
}
 
variable "sub_env" {}
 
variable "country_code" {}
 
variable "resource_group_name" {}
 
#######Storagea account variables start
 
# Variable declaration for resource group
variable "resource_group" {
  description = "Resource group for the storage account"
}
 
# Variable declaration for name of Storage Account to be created
variable "storage_account_name" {
  description = "Name of Storage Account"
  default = ""
}
 
# Variable declaration for Account_Tier of Storage account to be created
variable "account_tier" {
  description = "Storage Account Tier"
  default     = "Premium"
}
 
# Variable declaration for Account replication type of Storage account to be created
variable "account_replication_type" {
  description = "Storage Account Replication Type"
  default     = "LRS"
}
 
# Variable declaration for account kind of Storage account to be created
variable "account_kind" {
  description = "Storage Account kind of Storage"
  default     = "FileStorage"
}
 
# Variable declaration for Access Tier of Storage account to be created
variable "access_tier" {
  description = "Storage Account Access Tier"
  default     = "Hot"
}
 
variable "private_endpoint_subnet_id" {
  description = "create private endpoint at subnet if set"
  type        = list(string)
  default     = []
}
 
variable "subnet_id" {
  description = "Subnet Id for hostpool PE"
}
 
variable "private_endpoint_type_list" {
  description = "List of private endpoint to be created"
  type        = list(string)
  default     = []
}
 
variable "keyvault" {
  description = "Key Vault Object"
}
 
variable "enable_renew_storage_keys" {
  description = "If true, the storage key would be rotated during deployment"
  default     = true
}
 
variable "is_hns_enabled" {
  description = "If true, enables hierarchical namespace for Data Lake gen2"
  default     = false
}
 
# Variable declaration for Tags to be added
variable "tagvalue" {
  description = "Map of tag to be applied to resource"
  type        = map(string)
  default     = {}
}
 
variable "tag_map" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
 
variable "enable_diagnostic_logging" {
  description = "Turn on diagnostic logging"
  default     = true
}
 
variable "allow_zscaler_cidr" {
  description = "If true, only from SCB proxy"
  default     = true
}
 
variable "allowed_vnet_ids" {
  description = "VNet allowed to connect to the storage account, for service endpoint"
  type        = list(string)
  default     = []
}
 
variable "allow_azure_service_access" {
  description = "If true, FW rule allow azure service to access"
  default     = true
}
 
variable "disable_shared_access_key" {
  description = "To Disable Shared Access Key"
  default     = false
}
 
variable "enable_versioning" {
  description = "Enable versioning"
  default     = true
}
 
variable "delete_retention_days" {
  description = "Days to set at blob delete retention policy"
  default     = 7
}
 
variable "dafault_backup_vault_policy" {
  description = "Default backup policy set in Backup vault"
  default     = "default-blob-backup-policy-360days"
}
 
variable "enable_backup" {
  description = "If true, then storage account will be backed up using azure backup vauult and 360(max) days retention policy will applied to blobs and containers"
  default     = false
}
 
variable "container_delete_retention_days" {
  description = "Days to set at container delete retention policy"
  default     = 7
}
 
variable "share_delete_retention_days" {
  description = "Days to set at share delete retention policy"
  default     = 7
}
###### Storage account variables end
variable "enable_multisession" {
    description = "Enable/disable multisession hostpool"
    type        = bool
    default     = false
}
variable "MS_load_balancer_type" {
  description = "DepthFirst or BreadthFirst"
  default     = "BreadthFirst"
}
 
variable "custom_rdp_properties" {
  default     = "audiocapturemode:i:1;audiomode:i:0;enablerdsaadauth:i:0;targetisaadjoined:i:0;enablecredsspsupport:i:1;autoreconnection enabled:i:1;bandwidthautodetect:i:1;networkautodetect:i:1;compression:i:1;videoplaybackmode:i:1;encode redirected video capture:i:1;redirected video capture encoding quality:i:2;camerastoredirect:s:*;keyboardhook:i:2;redirectclipboard:i:0;redirectcomports:i:0;redirectlocation:i:0;redirectprinters:i:0;redirectsmartcards:i:0;redirectwebauthn:i:0;use multimon:i:1;selectedmonitors:s:;maximizetocurrentdisplays:i:1;singlemoninwindowedmode:i:1;screen mode id:i:2;smart sizing:i:1;dynamic resolution:i:1;devicestoredirect:s:;drivestoredirect:s:;usbdevicestoredirect:s:;"
}
 
variable "enable_singlesession" {
    description = "Enable/disable singlesession hostpool"
    type        = bool
    default     = false
}
 
variable "enable_remoteapp" {
    description = "Enable/disable remoteapp hostpool"
    type        = bool
    default     = false
}
 
variable "enable_workspace" {
   description = "Enable/disable workspace"
    type        = bool
    default     = false
}
 
variable "metaregion" {
}
variable "instance" {}
variable "log_analytics_workspace" {}
variable "enable_storage" {
  default = "false"
}
variable "remoteapps" {
    type = list(object({
    name        = string
    path        = string
    command_line_argument_policy = string
    icon_path = string
  }))
    default = [{
        name = "textpad"
        path = "c:\\program Files(x86)\\textpad 7\\textpad.exe"
        command_line_argument_policy = "DoNotAllow"
        icon_path                    = "c:\\windows\\installer\\9F53AC20-2D32-4341-9DA1-29DD40E2199E\\newshortcut1.exe"
    },
    {
        name = "activedirectory"
        path = "c:\\Windows\\System32\\dsa.msc"
        command_line_argument_policy = "DoNotAllow"
        icon_path                    = "c:\\windows\\system32\\dsacn.dll"
    },]
}