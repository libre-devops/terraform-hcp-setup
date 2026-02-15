component "foundations" {
  source = "./modules/foundations"

  providers = {
    azurerm      = provider.azurerm.write
    azurerm.rbac = provider.azurerm.rbac
  }


  inputs = {
    layer_name      = "foundations"
    env             = var.env
    short           = var.short
    short_region    = var.short_region
    long_region     = var.long_region
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    rbac_client_id  = var.rbac_client_id
  }
}