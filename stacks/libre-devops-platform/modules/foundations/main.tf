resource "azurerm_resource_group" "foundations" {
  name     = "rg-${var.short}-${var.short_region}-foundations"
  location = var.long_region
}

resource "azurerm_resource_group" "automation" {
  name     = "rg-${var.short}-${var.short_region}-automation"
  location = var.long_region
}

resource "azurerm_resource_group" "integration" {
  name     = "rg-${var.short}-${var.short_region}-integration"
  location = var.long_region
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.foundations.name
  location            = azurerm_resource_group.foundations.location

  name = "uid-${var.short}-${var.short_region}-${var.layer_name}"
}

resource "azurerm_role_assignment" "this" {
  provider             = azurerm.rbac
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  scope                = azurerm_resource_group.foundations.id
}