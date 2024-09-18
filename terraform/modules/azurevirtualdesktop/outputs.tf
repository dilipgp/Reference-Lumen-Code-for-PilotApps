output "hostpool_reg_token_multisession_in" {
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool_registration_info.multi_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_reg_token_multisession_sg" {
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool_registration_info.multi_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_reg_token_multisession_hk" {
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool_registration_info.multi_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_reg_token_multisession_my" {
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool_registration_info.multi_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_name_multisession_in" {
  description = "MultiSession Host Pool Name"
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool.hostpoolmultisession.id : ""
}
 
output "hostpool_name_multisession_sg" {
  description = "MultiSession Host Pool Name"
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool.hostpoolmultisession.id : ""
}
 
output "hostpool_name_multisession_hk" {
  description = "MultiSession Host Pool Name"
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool.hostpoolmultisession.id : ""
}
 
output "hostpool_name_multisession_my" {
  description = "MultiSession Host Pool Name"
  value = var.enable_multisession ? azurerm_virtual_desktop_host_pool.hostpoolmultisession.id : ""
}
 
output "hostpool_reg_token_singlesession_in" {
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool_registration_info.single_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_reg_token_singlesession_sg" {
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool_registration_info.single_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
#
#output "hostpool_reg_token_singlesession_hk" {
#  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool_registration_info.single_registration_info.token : ""
#  description = "Secret Token for Host Registration"
#  sensitive = true
#}
 
output "hostpool_reg_token_singlesession_my" {
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool_registration_info.single_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
 
output "hostpool_name_singlesession_in" {
  description = "SingleSession Host Pool Name"
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool.hostpoolsinglesession.id : ""
}
 
output "hostpool_name_singlesession_sg" {
  description = "SingleSession Host Pool Name"
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool.hostpoolsinglesession.id : ""
}
#
#output "hostpool_name_singlesession_hk" {
#  description = "SingleSession Host Pool Name"
#  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool.hostpoolsinglesession.id : ""
#}
output "hostpool_name_singlesession_my" {
  description = "SingleSession Host Pool Name"
  value = var.enable_singlesession ? azurerm_virtual_desktop_host_pool.hostpoolsinglesession.id : ""
}
output "hostpool_reg_token_remoteapp" {
  value = var.enable_remoteapp ? azurerm_virtual_desktop_host_pool_registration_info.remote_registration_info.token : ""
  description = "Secret Token for Host Registration"
  sensitive = true
}
output "hostpool_name_remoteapp" {
  description = "remoteapp Host Pool Name"
  value = var.enable_remoteapp ? azurerm_virtual_desktop_host_pool.remoteapphostpool.id : ""
}
 
#singlesession workspace
output "pworkspace" {
description = "workspace"
value = var.enable_singlesession ? azurerm_virtual_desktop_workspace.pworkspace.id : ""
}
 
#multisession workspace
output "mworkspace" {
description = "workspace"
value = var.enable_multisession ? azurerm_virtual_desktop_workspace.mworkspace.id : ""
}
 
#remoteapp workspace
output "rworkspace" {
description = "workspace"
value = var.enable_remoteapp ? azurerm_virtual_desktop_workspace.rworkspace.id : ""
}
 
# ##storage account outputs.
# # Returns the output of storage account name created here
# output "storage_account" {
#   value = {
#     id                  = azurerm_storage_account.storage_account.id
#     name                = azurerm_storage_account.storage_account.name
#     resource_group_name = azurerm_storage_account.storage_account.resource_group_name
#     location            = azurerm_storage_account.storage_account.location
#     identity            = azurerm_storage_account.storage_account.identity
#     primary_location    = azurerm_storage_account.storage_account.primary_location
#     secondary_location  = azurerm_storage_account.storage_account.secondary_location
#   }
# }
 
# output "storage_account_primary_secret" {
#   sensitive = true
#   value = {
#     primary_access_key             = azurerm_storage_account.storage_account.primary_access_key
#     primary_blob_connection_string = azurerm_storage_account.storage_account.primary_blob_connection_string
#   }
# }
 
# output "storage_account_secondary_secret" {
#   sensitive = true
#   value = {
#     primary_access_key             = azurerm_storage_account.storage_account.secondary_access_key
#     primary_blob_connection_string = azurerm_storage_account.storage_account.secondary_blob_connection_string
#   }
# }
 
# output "private_endpoint_ip_address" {
#   value = {
#     for k, v in azurerm_private_endpoint.ep : k => v.private_service_connection.0.private_ip_address
#   }
# }
 
# output "storage_encryption_key_name" {
#   value = azurerm_key_vault_key.storage_account_enc_key.name
# }