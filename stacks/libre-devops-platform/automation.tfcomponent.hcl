component "automation" {
  source     = "./modules/automation"
  depends_on = [component.foundations]

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "automation"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    rbac_client_id  = var.rbac_client_id

    resource_group_name = component.foundations.rg_automation_name
    resource_group_id   = component.foundations.rg_automation_id
    location            = component.foundations.rg_automation_location
  }
}