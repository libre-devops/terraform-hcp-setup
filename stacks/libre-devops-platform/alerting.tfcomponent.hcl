component "alerting" {
  source     = "./modules/alerting"
  depends_on = [component.automation-privileged]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "alerting"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_alerting_name
    resource_group_id   = component.foundation.rg_alerting_id
    location            = component.foundation.rg_alerting_location
  }
}