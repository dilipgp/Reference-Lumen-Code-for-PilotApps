variable "action_group_name" {
  description = "action_group name for resource"
}
 
variable "alert_config_name" {
  description = "alert_config name for resource"
}
 
variable "resource_group" {
  description = "Resource group name for resource placement"
}
 
variable "tagvalue" {
  description = "Map of tag to be applied to resource"
  type        = map(string)
}
 
variable "region" {
  description = "Region for resource placement"
  type        = string
}
variable "sa_1" {
}
 
variable "sa_2" {
}