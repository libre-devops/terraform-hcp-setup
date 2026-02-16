component "networking" {
  source     = "./modules/networking"
  depends_on = [component.foundation]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "networking"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_networking_name
    resource_group_id   = component.foundation.rg_networking_id
    location            = component.foundation.rg_networking_location
  }
}