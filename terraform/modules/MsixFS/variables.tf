

variable "subnet_id" {}
variable "resource_group_name" {}
variable "environment" {}

variable "region" {}
variable "enable_storage" {
  
}

variable "keyvault" {
  description = "Key Vault Object"
}

variable "region_suffix" {
  
}

variable "countrycode" {
  default     = "sg"
}
