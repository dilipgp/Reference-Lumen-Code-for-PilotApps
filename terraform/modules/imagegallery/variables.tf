variable "enable_gallery" {  
}
variable "gallery_name" {  
}
 
variable "resource_group" {
  description = "Resource group name"
  type        = string
}
 
variable "region" {
  description = "Region for resource placement"
  type        = string
}
 
variable "tags" {
  description = "Map of tag to be applied to resource"
  type        = map(string)
}
 
variable "definition_name_ms" {
}
 
variable "multisession_sku" {
  default = "win10-21h2-avd-g2"
}
variable "multisession_offer" {
  default = "Windows-10"
}
variable "multisession_publisher" {
  default = "MicrosoftWindowsDesktop"
}
 
variable "definition_name_ss" {
}
variable "singlesession_sku" {
  default = "Singlessesion"
}
variable "singlesession_offer" {
  default = "Windows"
}
variable "singlesession_publisher" {
  default = "Microsoft"
}
variable "environment" {
}