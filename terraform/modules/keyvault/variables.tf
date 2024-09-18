# Variable declaration for the app_name value to be added
variable "app_name" {
  description = "App name"
}
 
variable "region" {
  description = "Region for resource placement"
  type        = string
}
 
variable "resource_group" {
  description = "Resource group name"
  type        = string
}
 
variable "environment" {
  description = "Environment classification: development/testing/staging/production"
}
 
variable "tag_map" {
  description = "Map of tag to be applied to resource"
  type        = map(string)
}
 
# Variable declaration for SKU type of
variable "sku_name" {
  description = "SKU of Key Vault"
  default     = "premium"
}
 
variable "enabled_for_deployment" {
  description = "Enable for Deployment (allow VM access secret from key vault)"
  default     = false
}
 
variable "enabled_for_disk_encryption" {
  description = "Enable for Disk Encryption"
  default     = false
}
 
variable "enabled_for_template_deployment" {
  description = "Enable for Template Deployment (allow Azure Resource Manager access secret from key vault)"
  default     = false
}
 
variable "enable_rbac_authorization" {
  description = "Enable RBAC Authorization (Azure Key Vault uses RBAC for authorization of data actions)"
  default     = true
}
 
variable "purge_protection_enabled" {
  description = "Enable Purge Protection"
  default     = true
}
 
variable "public_network_access_enabled" {
  description = "Enable Public Access"
  default     = true
}
 
variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. Min 7 days to Max 90 days"
  default     = "90"
}
 
 
 
variable "whitelist_ips" {
  description = "IP addresses to be whitelisted"
  type        = list(string)
}
 
variable "keyvault_admin_ids" {
  description = "AAD Object List grant as admin of the key vault"
  type        = list(string)
  default     = []
}
 
variable "keyvault_key_writer_ids" {
  description = "AAD Object List grant as writer of the key vault"
  type        = list(string)
  default     = []
}
 
variable "keyvault_secret_writer_ids" {
  description = "AAD Object List grant as writer of the key vault"
  type        = list(string)
  default     = []
}
 
variable "keyvault_certificate_writer_ids" {
  description = "AAD Object List grant as writer of the key vault"
  type        = list(string)
  default     = []
}
 
variable "keyvault_reader_ids" {
  description = "AAD Object List grant as reader of the key vault"
  type        = list(string)
  default     = []
}
 
variable "keyvault_secert_reader_ids" {
  description = "AAD Object List grant as reader of the key vault"
  type        = list(string)
  default     = []
}
 
variable "private_endpoint_subnet_id" {
  description = "create private endpoint at subnet if set"
  type        = list(string)
}
 
variable "azure_resource_lock_enable" {
  type    = bool
  default = true
}
 
variable "env_short_name" {
  type = string
}
 
variable "location_short" {
  type = string
}
 
variable "kv_instance" {
  type = string
}
 
variable "log_analytics_workspace" {
 
}