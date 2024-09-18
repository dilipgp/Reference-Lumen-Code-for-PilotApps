variable "rg" {
  description = "The resource group object"
}
variable "region" {}
variable "vm_name" {
  description = "Name of VM, if only requst one"
}

variable "sub_env" {
  description = "Application Name"
}

variable "app_name" {
  description = "Application Name"
}

variable "region_suffix" {
  description = "Application Name"
}

variable "dcr_id" {
  description = "Application Name"
}

variable "subnet_id" {
  description = "Subnet Id for VM placement"
}

variable "vm_size" {
  description = "Size of VM"
  default     = "Standard_D4s_v3"
}

variable "managed_identity_ids" {
  description = "A list of user managed identity ids to be assigned to the VM"
  type        = list(string)
  default     = []
}

 

variable "vm_disk_type" {
  description = "Type of Managed disk"
  default     = "StandardSSD_LRS"
}

 

variable "vm_osadmin_user" {
  description = "username of vm os admin"
  default     = "scbuser"
}

 

# variable "vm_osadmin_password" {
#   description = "password of vm os admin"
# }

 

variable "tag_map" {
  description = "Tags for resource"
  type        = map(string)
  default     = {}
}

 

variable "vm_image_id" {
  description = "Id of VM image"
}

 

variable "vm_count" {
  description = "Number of VM request"
  #default     = 1
}

 

variable "disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the 128GB size used in the image."
  default     = 254
}

 

variable "data_disk_size_gb" {
  type    = list(number)
  default = []
}

 

variable "storage_account_type" {
  description = "The type of storage to use for the managed disk"
  default     = "StandardSSD_LRS"
}

 

variable "create_option" {
  default = "Empty"
}

 

variable "caching" {
  description = "The caching behavior of data disk. Valid options are: None, ReadOnly and ReadWrite (defaults None)"
  default     = "ReadWrite"
}

 

variable "data_disk_create_option" {
  default = "Attach"
}

 

variable "pem_public_key" {
  description = "PEM format public key to encrypted password"
  default     = ""
}

 

variable "extension_settings" {
  default = null
}

 

variable "extension_protected_settings" {
  default = null
}

 

variable "vm_extension_enabled" {
  description = "Enable VM Extension for windows virtual machine"
  default     = false
}

 

variable "domainjoin" {
  description = "Please set true to join your servers to domain"
  type        = bool
  default     = false
}
variable "OUPath" {
  description = "ou path for the respective sessionhosts"
}
variable "vm_poolext_enabled" {
   description = "Please set true to AddSessionHost in hostpools"
  type        = bool
  default     = false

}
variable "network_sg" {
  description = "network security group object"
  default     = null
}

 

variable "create_timeout" {
  description = "provide extension timeout variables in minutes ex 60m, 120m"
  type        = string
  default     = "30m"
}
variable "wvddsc_enable"{
  default = false
  description = "enable this to add VM's into Hostpool"
}

 

 

variable "environment" {
  description = "Environment classification: development|testing|staging|production"
  default     = ""
}

 

//Change done as part of JIRA [AZCORE-81] to enable accelerated networking
variable "enable_accelerated_networking" {
  description = "The option to enable the accelerated networking in NIC"
  default     = true
}

 

#Part of AZTHREE-359 for disk max shares

 

variable "max_shares_number" {
  description = "Max number of vm that can be mounted to disk"
  default     = 3
}

 

####### AZTHREE-360#####
variable "email_receiver_name" {
  description = "Action group email receiver name"
  type        = string
  default     = "sendtoadmin"
}

 

variable "email_receiver_email" {
  description = "Action group email receiver email"
  type        = string
  default     = "admin@contoso.com"
}

 

variable "action_grp_create" {
  description = "Creation of action_group"
  type        = bool
  default     = false
}

 

variable "action_grp_name" {
  description = "Action Group Name (Must be unique)"
  type        = string
  default     = "Win-VM-Action-Group"
}

 

 

##### Available memory alerts #####
variable "avail_memory_enable" {
  description = "Enabling available memory alert"
  type        = bool
  default     = false
}

 

variable "avail_memory_severity" {
  description = "Severity level for available memory alert"
  default     = 0 #critical alert
}

 

variable "avail_memory_frequency" {
  description = "The evaluation frequency of this available memory Alert"
  type        = string
  default     = "PT1M"
}

 

variable "avail_memory_win_size" {
  description = "The period of time that is used to monitor available memory activity"
  type        = string
  default     = "PT5M"
}

 

variable "avail_memory_threshold" {
  description = "Threshold for availabile memory alert"
  default     = 100000000 #100MB
}

 

##### Percent CPU alerts #####
variable "percent_cpu_enable" {
  description = "Enabling percent cpu alert"
  type        = bool
  default     = false
}

 

variable "percent_cpu_severity" {
  description = "Severity level for percent cpu alert"
  default     = 2 #Warning
}

 

variable "percent_cpu_frequency" {
  description = "The evaluation frequency of this percent cpu Alert"
  type        = string
  default     = "PT1M"
}

 

variable "percent_cpu_win_size" {
  description = "The period of time that is used to monitor percent cpu activity"
  type        = string
  default     = "PT5M"
}

 

variable "percent_cpu_threshold" {
  description = "Threshold for percent cpu alert"
  default     = 80
}

 

variable "hostpoolregtoken" {}
variable "hostpoolname" {}
#variable "dcr_id" {}
variable "enable_ama_extension" { 
}

/*
variable "msix_enabled" {
# default = false
}
variable "deployment_subscription_name" {
  description = "subscription name to install msix packages"
}
variable "ImageUNCPath" {
  description = "For example, \\storageaccount.file.core.windows.net\\msixshare\\appfolder\\MSIXimage.vhd."
}
variable "PackageDisplayName" {
  description = "package dispaly name for ex : Adobe"
}
variable "packageaction" {
description="accepted value is   to add MSIX package or REMOVEMSIX - to remove MSIX package"
}
variable "msix_rg" {}
*/