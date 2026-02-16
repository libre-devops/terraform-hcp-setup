component "integration" {
  source     = "./modules/integration"
  depends_on = [component.foundation]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "integration"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_integration_name
    resource_group_id   = component.foundation.rg_integration_id
    location            = component.foundation.rg_integration_location
  }
}