component "foundation" {
  source = "./modules/foundation"

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "foundation"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region
  }
}