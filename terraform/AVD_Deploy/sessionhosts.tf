module "multi_sessionhost_in"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = var.multivm_count_in
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.multivm_name_in
    tag_map               = var.tags  
    hostpoolname          = module.host_pools_in[count.index].hostpool_name_multisession_in
    hostpoolregtoken      = module.host_pools_in[count.index].hostpool_reg_token_multisession_in
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "multi_sessionhost_sg"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = var.multivm_count_sg
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.multivm_name_sg
    tag_map               = var.tags
    hostpoolname          = module.host_pools_sg[count.index].hostpool_name_multisession_sg
    hostpoolregtoken      = module.host_pools_sg[count.index].hostpool_reg_token_multisession_sg
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "single_sessionhost_sg"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = var.singlevm_count
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.svm_image_id
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.singlevm_name_sg
    tag_map               = var.tags
    hostpoolname          = module.host_pools_sg[count.index].hostpool_name_singlesession_sg
    hostpoolregtoken      = module.host_pools_sg[count.index].hostpool_reg_token_singlesession_sg
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ss_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
module "multi_sessionhost_packaging"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = var.multivm_count_hk
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.packagingvm_name_hk
    tag_map               = var.tags
    hostpoolname          = module.host_pools_hk[count.index].hostpool_name_multisession_hk
    hostpoolregtoken      = module.host_pools_hk[count.index].hostpool_reg_token_multisession_hk
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.mgmt_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "multi_sh_my_light"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = "2"
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    vm_size               = var.multi_size
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.multivm_light_my
    tag_map               = var.tags
    hostpoolname          = module.host_pools_my_light[count.index].hostpool_name_multisession_my
    hostpoolregtoken      = module.host_pools_my_light[count.index].hostpool_reg_token_multisession_my
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "multi_sh_my_medium"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = "4"
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    vm_size               = var.multi_size
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.multivm_medium_my
    tag_map               = var.tags
    hostpoolname          = module.host_pools_my[count.index].hostpool_name_multisession_my
    hostpoolregtoken      = module.host_pools_my[count.index].hostpool_reg_token_multisession_my
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "multi_sh_my_heavy"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = "2"
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    vm_size               = var.multi_size
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.multivm_heavy_my
    tag_map               = var.tags
    hostpoolname          = module.host_pools_my_heavy[count.index].hostpool_name_multisession_my
    hostpoolregtoken      = module.host_pools_my_heavy[count.index].hostpool_reg_token_multisession_my
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "remoteapp_sh_my"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = "2"
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.mvm_image_id
    vm_size               = var.multi_size
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.remoteappvm_my
    tag_map               = var.tags
    hostpoolname          = module.host_pools_my_light[count.index].hostpool_name_remoteapp
    hostpoolregtoken      = module.host_pools_my_light[count.index].hostpool_reg_token_remoteapp
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ms_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}
 
module "single_sh_my_medium"{
    source                = "../modules/sessionhosts"
    count                 = var.env_short_name == "stg" ? 1 : 0
    app_name              = var.app_name
    sub_env               = var.environment_subtype
    region_suffix         = var.regionsuffix
    vm_count              = "2"
    subnet_id             = data.azurerm_subnet.session_host_sub[count.index].id
    vm_image_id           = var.svm_image_id
    vm_size               = var.single_size
    rg                    = azurerm_resource_group.rg[count.index]
    region                = var.region
    vm_name               = var.singlevm_medium_my
    tag_map               = var.tags
    hostpoolname          = module.host_pools_my[count.index].hostpool_name_singlesession_my
    hostpoolregtoken      = module.host_pools_my[count.index].hostpool_reg_token_singlesession_my
    environment           = var.environment
    domainjoin            = var.domainjoin
    wvddsc_enable         = var.wvddsc_enable
    OUPath                = var.ss_OUPath
    enable_ama_extension  = var.enable_ama_extension
    dcr_id                = module.data_collection_rule[count.index].dcr_id
}