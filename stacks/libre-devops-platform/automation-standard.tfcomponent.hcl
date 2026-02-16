component "automation-standard" {
  source     = "./modules/automation-standard"
  depends_on = [component.sentinel]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "automation-standard"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_automation_standard_name
    resource_group_id   = component.foundation.rg_automation_standard_id
    location            = component.foundation.rg_automation_standard_location
  }
}