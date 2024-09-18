app_name                            = "cds"     //APP NAME
region                              = "southeastasia"   //REGION REQUESTED
environment                         = "staging" //development|production
environment_subtype                 = "stg"
env_short_name                      = "stg"
location_short                      = "sea"
vnet_rg_name                        = "rg-cds-vnet-stg-sea-001"
owner_groups                        = [] //ADD THE AD GROUP. 0441 IS THE FACTORY ID GENERATED EX: SUZ1-Users-Azure-NonProd-Order0441-Adm
rg_name                             = "rg-cds-app-stg-sea-001"
vnet_rg_key                         = "app"
tags = {
    "client_segment"                = "ts"
    "ito_unit"                      = "cis"
    "app_id"                        = "51609"
    "component"                     = "AVD"
    "component_id"                  = "cis"
    "stack_id"                      = "001"
    "execution_fabric"              = ""
    "country_instance_located"      = "ire"
    "country_instance_served"       = "global"
    "environment_subtype"           = "stg"
    "costcentre_id"                 = "1509275901"
    "clarity_id"                    = "BAU"
    "department"                    = "CDS"
    "ExcludeMdeAutoProvisioning"    = true
}
regionsuffix                        = "sea"
country_code_in                     = "in"
country_code_hk                     = "hk"
country_code_sg                     = "sg"
country_code_my                     = "my"
metaregion                          = "centralindia"
sessions_light                      = "8"
sessions_medium                     = "6"
sessions_heavy                      = "4"
sku_light                           = "l"
sku_medium                          = "m"
sku_heavy                           = "h"
expdate                             = "2024-03-28T00:00:00Z"
enable_singlesession                = true
enable_multisession                 = true
enable_remoteapp                    = true
enable_ama_extension                = true
storage_account_create              = "true"
enable_backup                       = "false"
quota                               = "1000"
account_replication_type            = "LRS"
kv_instance                         = "001"
 
# VMconfig
multivm_count_sg                    = "4"
multivm_count_in                    = "0"
multivm_count_hk                    = "1"
mvm_image_id                        = "/subscriptions/cd8b5e40-c586-40ad-a1e0-0f86ce70c9b0/resourceGroups/rg-cds-img-stg-sea-001/providers/Microsoft.Compute/galleries/acgcdsstg001/images/Multisession"
multivm_name_in                     = "INQLCP200"
multivm_name_sg                     = "SGQLCP100"
multivm_name_hk                     = "HKQLCP100"
multivm_light_my                    = "MYQLCPML0"
multivm_medium_my                   = "MYQLCPMM0"
multivm_heavy_my                    = "MYQLCPMH0"
remoteappvm_my                      = "MYQLCPRA0"
packagingvm_name_hk                 = "HKQLCP200"
domainjoin                          = "true"
ms_OUPath                           = "OU=Multi Session,OU=Windows 10,OU=CDS,OU=PreDeployment,OU=VDI,DC=zone1,DC=scb,DC=net"
ss_OUPath                           = "OU=Single Session,OU=Windows 10,OU=CDS,OU=PreDeployment,OU=VDI,DC=zone1,DC=scb,DC=net"
mgmt_OUPath                         = "OU=Management,OU=Windows 10,OU=CDS,OU=PreDeployment,OU=VDI,DC=zone1,DC=scb,DC=net"
wvddsc_enable                       = "true"
singlevm_count                      = "4"
svm_image_id                        = "/subscriptions/cd8b5e40-c586-40ad-a1e0-0f86ce70c9b0/resourceGroups/rg-cds-img-stg-sea-001/providers/Microsoft.Compute/galleries/acgcdsstg001/images/SinglesessionTestAb"
singlevm_name_in                    = "INQSCP100"
singlevm_name_sg                    = "SGQSCP100"
singlevm_light_my                   = "MYQSCPSL0"
singlevm_medium_my                  = "MYQSCPSM0"
singlevm_heavy_my                   = "MYQSCPSH0"
multi_size                          = "Standard_D8s_v5"
single_size                         = "Standard_D4s_v5"
 
# keyvault
admin_users                         = []
admin_groups                        = []
key_writer_users                    = []
key_writer_groups                   = []
secret_writer_users                 = []
secret_writer_groups                = []
certificate_writer_users            = []
certificate_writer_groups           = []
reader_users                        = []
reader_groups                       = []
secret_reader_users                 = []
secret_reader_groups                = []
azure_resource_lock_enable          = "true"
whitelist_ips                       = ["165.225.196.0/23", "136.226.252.0/23", "147.161.166.0/23", "58.33.27.187/32", "136.226.90.0/23", "165.225.234.0/23", "165.225.220.0/23", "136.226.230.0/23", "147.161.248.0/23", "165.225.124.0/23", "210.13.127.43/32", "147.161.224.0/23", "165.225.104.0/24", "165.225.80.0/22", "165.225.116.0/23", "147.161.236.0/23", "165.225.112.0/23", "136.226.254.0/23", "136.226.50.0/23", "104.129.194.0/23", "165.225.38.0/23", "165.225.122.0/23", "210.13.127.39/32", "165.225.106.0/23", "136.226.236.0/23", "165.225.16.0/23", "165.225.230.0/23", "136.226.52.0/23", "136.226.48.0/23", "58.33.27.183/32", "165.225.120.0/23", "136.226.242.0/23", "136.226.234.0/23", "136.226.80.0/23", "165.225.8.0/23", "165.225.206.0/23", "165.225.198.0/23", "136.226.232.0/23", "136.226.228.0/23", "136.226.244.0/23", "136.226.250.0/23"]
use_existing_network_watcher        = true
key_vault_key_creation              = true
key_name                            = "des-key-01"
enable_storage                      = true
 
# vnetconfig
vnet_config = {
  vpc_cidr_list                                 = ["10.255.92.0/25", "10.255.92.128/27"]
  dns_servers                                   = ["10.255.64.132"]
  subnets = {
    subnet_sh = {
      index                                     = "sh"
      subnet_list                               = ["10.255.92.0/25"]
      nsg_set                                   = []
      traffic_analytics_enabled                 = false
      private_endpoint_network_policies_enabled = true
    }
    subnet_pe = {
      index                                     = "pe"
      subnet_list                               = ["10.255.92.128/27"]
      nsg_set                                   = []
      traffic_analytics_enabled                 = false
      private_endpoint_network_policies_enabled = true
    }
  }
}
spoke_vnet_peering_enable                       = false