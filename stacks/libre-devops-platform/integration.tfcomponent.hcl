component "integration" {
  source     = "./modules/integration"
  depends_on = [component.automation]

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
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    rbac_client_id  = var.rbac_client_id

    resource_group_name = component.foundations.rg_integration_name
    resource_group_id   = component.foundations.rg_integration_id
    location            = component.foundations.rg_integration_location
  }
}