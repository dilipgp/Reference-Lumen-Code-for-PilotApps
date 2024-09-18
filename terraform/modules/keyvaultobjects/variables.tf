#Key Creation
 
variable "key_vault_id" {
  description = "Key Vault for encryption key"
}
 
variable "key_name" {
  description = "Name for encryption key"
  type        = string
  default     = "key"
}
 
variable "key_type" {
  description = "Key type for encryption key"
  default     = "RSA-HSM"
}
 
variable "key_size" {
  description = "Key size for encryption key"
  default     = "2048"
}
 
variable "key_expiration_date" {
  description = "Expiration date for encryption key in hours"
  default     = "2160h"
}
 
variable "key_opts" {
  description = "Key opts for encryption key"
  type        = list(string)
  default     = [ "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey",]
}
 
variable "key_tagvalue" {
  description = "Map of tag to be applied to resource"
  type        = map(string)
  default     = {}
}
 
variable "key_rotate_before" {
  description = "How many days before expiry encryption key has to be rotated in days?"
  default     = "15"
}
 
variable "key_expiry_time" {
  description = "Expiration time for encryption key after rotation in days"
  default     = "90"
}
 
variable "key_notify_before" {
  description = "How many days before key expiry notification has to be sent in days?"
  default     = "30"
}