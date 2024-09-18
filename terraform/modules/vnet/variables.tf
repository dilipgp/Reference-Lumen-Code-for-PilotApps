variable "rg_name" {
}
 
variable "rg_location" {
}
 
variable "app_name" {
}
 
variable "environment" {
}
 
variable "env_short_name" {
  type = string
}
 
variable "location_short" {
  type = string
}
 
variable "tags" {
  type    = map(string)
  default = {}
}
 
variable "use_existing_network_watcher" {
  type = bool
}
 
variable "vnet_config" {
  description = "VNet configuration"
}
 
variable "spoke_vnet_peering_enable" {
  type = bool
}