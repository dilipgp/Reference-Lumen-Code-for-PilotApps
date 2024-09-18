data "azuread_user" "app_admin_user" {
  count               = length(var.admin_users)
  user_principal_name = var.admin_users
}
 
data "azuread_group" "app_admin_group" {
  count        = length(var.admin_groups)
  display_name = var.admin_groups
}
 
data "azuread_user" "app_key_writer_user" {
  count               = length(var.key_writer_users)
  user_principal_name = var.key_writer_users
}
 
data "azuread_group" "app_key_writer_group" {
  count        = length(var.key_writer_groups)
  display_name = var.key_writer_groups
}
 
data "azuread_user" "app_secret_writer_user" {
  count               = length(var.secret_writer_users)
  user_principal_name = var.secret_writer_users
}
 
data "azuread_group" "app_secret_writer_group" {
  count        = length(var.secret_writer_groups)
  display_name = var.secret_writer_groups
}
 
data "azuread_user" "app_certificate_writer_user" {
  count               = length(var.certificate_writer_users)
  user_principal_name = var.certificate_writer_users
}
 
data "azuread_group" "app_certificate_writer_group" {
  count        = length(var.certificate_writer_groups)
  display_name = var.certificate_writer_groups
}
 
data "azuread_user" "app_reader_user" {
  count               = length(var.reader_users)
  user_principal_name = var.reader_users
}
 
data "azuread_group" "app_reader_group" {
  count        = length(var.reader_groups)
  display_name = var.reader_groups
}
 
data "azuread_user" "app_secret_reader_user" {
  count               = length(var.secret_reader_users)
  user_principal_name = var.secret_reader_users
}
 
data "azuread_group" "app_secret_reader_group" {
  count        = length(var.secret_reader_groups)
  display_name = var.reader_groups
}
 
data "azurerm_resource_group" "rg" {
  name     = "clouddesktop-eastasia-rg"
}