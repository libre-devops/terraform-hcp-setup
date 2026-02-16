```hcl
resource "azurerm_resource_group" "this" {
  name     = "rg-${var.short}-${var.short_region}-${var.layer_name}"
  location = var.long_region
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name = "uid-${var.short}-${var.short_region}-${var.layer_name}"
}

resource "azurerm_role_assignment" "this" {
  provider             = azurerm.rbac
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  scope                = azurerm_resource_group.this.id
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.60.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.60.0 |
| <a name="provider_azurerm.rbac"></a> [azurerm.rbac](#provider\_azurerm.rbac) | 4.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment short code. Allowed values: dev, uat, prd. | `string` | `"dev"` | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | The layer name of this terraform run | `string` | `"foundation"` | no |
| <a name="input_long"></a> [long](#input\_long) | Long resource prefix used in naming (lowercase letters/numbers/hyphens). | `string` | `"libre-devops"` | no |
| <a name="input_long_region"></a> [long\_region](#input\_long\_region) | Long code for Azure region. Allowed values: uksouth, ukwest, westeurope. | `string` | `"uksouth"` | no |
| <a name="input_rbac_client_id"></a> [rbac\_client\_id](#input\_rbac\_client\_id) | Client ID for the RBAC Service Principal used by the azurerm.rbac provider alias. | `string` | `"373b0885-3dc7-4ee1-ae61-de80b175e3f2"` | no |
| <a name="input_short"></a> [short](#input\_short) | Short resource prefix used in naming (lowercase letters/numbers/hyphens). | `string` | `"libd"` | no |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short code for Azure region. Allowed values: uks, ukw, euw. | `string` | `"uks"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure subscription ID (GUID) for the targeted subscription. | `string` | `"bf6128f4-93cb-45d4-bc13-7b3be2eea1c5"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure tenant ID (GUID). Typically passed as TF\_VAR. | `string` | `"01b9e453-84bc-4dc5-88de-a97a1fd42455"` | no |
| <a name="input_tfe_project_name"></a> [tfe\_project\_name](#input\_tfe\_project\_name) | The project name of the TFE project, normally passed as a TF\_VAR | `string` | `"libre-devops"` | no |

## Outputs

No outputs.
