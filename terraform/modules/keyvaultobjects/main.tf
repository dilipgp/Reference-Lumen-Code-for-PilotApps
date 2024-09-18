#Key Creation
resource "azurerm_key_vault_key" "key" {
  name            = var.key_name
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = var.key_size
  not_before_date = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'" , timestamp())
  expiration_date = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'" , timeadd(timestamp(), var.key_expiration_date))
  key_opts        = var.key_opts
  tags            = var.key_tagvalue
 
#Removing rotation policy as its been introduced in v3.46 but djcore is using v3.45  
  rotation_policy {
    automatic {
      #time_after_creation = "P${var.rotate_after}D"
      time_before_expiry = "P${var.key_rotate_before}D"
    }
    expire_after         = "P${var.key_expiry_time}D"
    notify_before_expiry = "P${var.key_notify_before}D"
  }

  lifecycle {
    ignore_changes = [not_before_date, expiration_date]
  }
}