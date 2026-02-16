component "sentinel" {
  source     = "./modules/sentinel"
  depends_on = [component.integration]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "sentinel"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_sentinel_name
    resource_group_id   = component.foundation.rg_sentinel_id
    location            = component.foundation.rg_sentinel_location
  }
}