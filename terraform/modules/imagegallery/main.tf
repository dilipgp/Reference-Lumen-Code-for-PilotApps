# Source code for creating Shared Image gallery
resource "azurerm_shared_image_gallery" "image_gallery" {
  count               = var.enable_gallery ? 1 : 0
  name                = lower(var.gallery_name)
  resource_group_name = var.resource_group
  location            = var.region
  description         = "AVD Shared Images"
  tags                = var.tags
}
 
resource "azurerm_shared_image" "image_definition_ms" {
  count               = var.enable_gallery ? 1 : 0
  name                = var.definition_name_ms
  gallery_name        = azurerm_shared_image_gallery.image_gallery[0].name
  resource_group_name = var.resource_group
  location            = var.region
  os_type             = "Windows"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.multisession_publisher
    offer     = var.multisession_offer
    sku       = var.multisession_sku
  }
  tags = var.tags
}
 
resource "azurerm_shared_image" "image_definition_ss" {
  count               = var.enable_gallery ? 1 : 0
  name                = var.definition_name_ss
  gallery_name        = azurerm_shared_image_gallery.image_gallery[0].name
  resource_group_name = var.resource_group
  location            = var.region
  os_type             = "Windows"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.singlesession_publisher
    offer     = var.singlesession_offer
    sku       = var.singlesession_sku
  }
  tags = var.tags
}