resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = var.resource_group_name
  location            = var.long_region

  name = "uid-${var.short}-${var.short_region}-${var.layer_name}"
}

resource "azurerm_role_assignment" "this" {
  provider             = azurerm.rbac
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  scope                = var.resource_group_id
}