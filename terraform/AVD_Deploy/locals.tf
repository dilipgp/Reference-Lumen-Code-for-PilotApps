locals {
  ou = {
  prd = "OU=W2K19 Servers,OU=Servers,OU=Cloud,DC=zone1,DC=scb,DC=net"
 
  ra_devOUPath = "OU=remotepapp,OU=Onboarding,OU=Cloud Desktops,OU=HK,OU=VDI,DC=zone1,DC=scbdev,DC=net"
  ss_devOUPath = "OU=singlesession,OU=Onboarding,OU=Cloud Desktops,OU=HK,OU=VDI,DC=zone1,DC=scbdev,DC=net"
}
  admin_aad_object_ids              = concat(data.azuread_user.app_admin_user.*.id, data.azuread_group.app_admin_group.*.id)
  key_writer_aad_object_ids         = concat(data.azuread_user.app_key_writer_user.*.id, data.azuread_group.app_key_writer_group.*.id)
  secret_writer_aad_object_ids      = concat(data.azuread_user.app_secret_writer_user.*.id, data.azuread_group.app_secret_writer_group.*.id)
  certificate_writer_aad_object_ids = concat(data.azuread_user.app_certificate_writer_user.*.id, data.azuread_group.app_certificate_writer_group.*.id)
  reader_aad_object_ids             = concat(data.azuread_user.app_reader_user.*.id, data.azuread_group.app_reader_group.*.id)
  secret_reader_aad_object_ids      = concat(data.azuread_user.app_secret_reader_user.*.id, data.azuread_group.app_secret_reader_group.*.id)
}