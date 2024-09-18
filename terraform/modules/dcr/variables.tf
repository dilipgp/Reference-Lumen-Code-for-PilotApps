variable "dcr_name" {
  description = "dcr name"
}
 
variable "resource_group" {
  description = "The resource group object"
}
 
variable "region" {
  description = "Region for resource placement"
  type        = string
}
 
variable "tag_map" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
 
variable "laws_id" {
  description = "LAWS Id"
  type        = string
}