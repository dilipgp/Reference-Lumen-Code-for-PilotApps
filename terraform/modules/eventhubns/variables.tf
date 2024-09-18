variable "resource_group" {
  description = "The resource group object"
}
 
 
variable "encryption_customer_managed_key" {
  description = "The customer managed key for event hub namespace encryption"
  type        = string
}
 
variable "key_vault_id" {
  description = "The key vault id that customer managed key in"
  type        = string
}
 
variable "namespace_name" {
  description = "Event Hubs namespace name"
  type        = string
}
 
variable "private_endpoint_subnet_id" {
  description = "the subnet id that private endpoint will be created in, and NS would disallow access from public endpoint"
  type        = string
}
 
variable "capacity" {
  description = "namespace capacity"
  type        = number
  default     = 1
}
 
variable "trust_azure_services" {
  description = "Namespace trust Azure services"
  default     = false
}
 
variable "tag_map" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
 
variable "infra_encryption_enabled" {
  description = "to enable infra encryption"
  type        = bool
  default     = false
}
 
variable "name" {
  description = "name for the Event Hub"
}
 
variable "partition_count" {
  description = "Event Hub partition count, between 2 and 32"
  default     = 2
}
 
variable "message_retention" {
  description = "Message retention period, in day(s)"
  default     = 1
}
 
variable "storage_account_id" {
  description = "Storage Account id for capture, to enable long term retention. Need to provide the blob container name at the same time."
  default     = null
}
 
variable "blob_container_name" {
  description = "Blob Container resource name for capture, to enable long term retention"
  default     = null
}
 
variable "capture_archive_name_format" {
  description = "Capture Archive Name format"
  default     = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
}
 
variable "consumer_groups" {
  description = "List of Consumer Groups"
  type        = list(string)
  default     = []
}
 
variable "shared_access_policy_name" {
  description = "Name of shared access policy for event hub"
  default     = "ListenSendSharedAccessPolicy"
}
 
variable "shared_access_policy_claims" {
  description = "Claims for the shared access policy. The values should be with 'Send', 'Listen' or 'Manage'"
  default     = ["Send", "Listen"]
}