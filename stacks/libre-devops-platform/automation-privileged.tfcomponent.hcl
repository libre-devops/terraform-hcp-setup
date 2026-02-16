component "automation-privileged" {
  source     = "./modules/automation-privileged"
  depends_on = [component.automation-standard]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "automation-privileged"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region

    resource_group_name = component.foundation.rg_automation_privileged_name
    resource_group_id   = component.foundation.rg_automation_privileged_id
    location            = component.foundation.rg_automation_privileged_location
  }
}