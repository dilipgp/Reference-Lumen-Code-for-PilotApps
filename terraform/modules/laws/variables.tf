variable "data_export_rule" {
  type = list(object({
    name                    = string
    destination_resource_id = string
    table_names             = list(string)
    enabled                 = optional(bool, true)
  }))
  default = []
}

variable "name" {}
 
variable "location" {}
 
variable "resource_group_name" {}