```hcl
locals {
  workspaces = toset(["foundations", "automation", "integrations"])
  shared_vars = {
    env              = var.env
    short_region     = var.short_region
    long_region      = var.long_region
    tenant_id        = var.tenant_id
    subscription_id  = var.subscription_id
    long             = var.long
    short            = var.short
    tfe_project_name = var.tfe_project_name
  }
  run_phases = toset(["plan", "apply"])

  fic_bindings = {
    for pair in setproduct(local.workspaces, local.run_phases) :
    "${pair[0]}:${pair[1]}" => {
      workspace_short = pair[0] # foundations / automation / integrations
      run_phase       = pair[1] # plan / apply
    }
  }
}

resource "tfe_project" "this" {
  name         = var.tfe_project_name
  organization = data.tfe_organization.current.name
}

resource "tfe_workspace" "this" {
  for_each     = local.workspaces
  name         = "${var.long}-${each.value}-${var.env}"
  organization = data.tfe_organization.current.name
  project_id   = tfe_project.this.id

  terraform_version = "1.14.5"
  working_directory = each.value
}

resource "tfe_variable_set" "shared" {
  name         = "${var.long}-${var.env}-shared"
  description  = "Shared variables for all workspaces (${var.env})."
  organization = data.tfe_organization.current.name
}

resource "tfe_workspace_variable_set" "attach_shared" {
  for_each        = tfe_workspace.this
  workspace_id    = each.value.id
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "shared" {
  for_each        = local.shared_vars
  variable_set_id = tfe_variable_set.shared.id

  key         = each.key
  value       = each.value
  category    = "terraform"
  sensitive   = false
  description = "Shared variable ${each.key}"
}

resource "tfe_variable" "tfc_azure_provider_auth" {
  variable_set_id = tfe_variable_set.shared.id

  key         = "TFC_AZURE_PROVIDER_AUTH"
  value       = "true"
  category    = "env"
  sensitive   = false
  description = "Enable AzureRM OIDC auth in HCP Terraform runs."
}

resource "tfe_variable" "tfc_azure_run_client_id_write" {
  variable_set_id = tfe_variable_set.shared.id

  key         = "TFC_AZURE_RUN_CLIENT_ID"
  value       = azuread_application.hcp_terraform_write.client_id
  category    = "env"
  sensitive   = true
  description = "Client ID used by HCP Terraform OIDC runs for WRITE operations."
}

resource "tfe_variable" "tfc_azure_run_client_id_rbac" {
  variable_set_id = tfe_variable_set.shared.id

  key         = "TFC_AZURE_RUN_CLIENT_ID_RBAC"
  value       = azuread_application.hcp_terraform_rbac.client_id
  category    = "env"
  sensitive   = true
  description = "Client ID used by HCP Terraform OIDC runs for RBAC operations (separate provider config)."
}

resource "azuread_application" "hcp_terraform_write" {
  display_name = "spn-oidc-hcp-write-${var.short}-${var.env}"
}

resource "azuread_service_principal" "hcp_terraform_write" {
  client_id = azuread_application.hcp_terraform_write.client_id
}

resource "azuread_application_federated_identity_credential" "hcp_write" {
  for_each = local.fic_bindings

  application_id = azuread_application.hcp_terraform_write.id
  display_name   = "${azuread_application.hcp_terraform_write.display_name}-${each.value.workspace_short}-${each.value.run_phase}"
  description    = "HCP Terraform ${each.value.run_phase} for ${each.value.workspace_short} (WRITE SP)"

  issuer    = "https://app.terraform.io"
  audiences = ["api://AzureADTokenExchange"]

  subject = join(":", [
    "organization", data.tfe_organization.current.name,
    "project", var.tfe_project_name,
    "workspace", tfe_workspace.this[each.value.workspace_short].name,
    "run_phase", each.value.run_phase
  ])
}

resource "azuread_application" "hcp_terraform_rbac" {
  display_name = "spn-oidc-hcp-rbac-${var.short}-${var.env}"
}

resource "azuread_service_principal" "hcp_terraform_rbac" {
  client_id = azuread_application.hcp_terraform_rbac.client_id
}

resource "azuread_application_federated_identity_credential" "hcp_rbac" {
  for_each = local.fic_bindings

  application_id = azuread_application.hcp_terraform_rbac.id
  display_name   = "${azuread_application.hcp_terraform_rbac.display_name}-${each.value.workspace_short}-${each.value.run_phase}"
  description    = "HCP Terraform ${each.value.run_phase} for ${each.value.workspace_short} (RBAC SP)"

  issuer    = "https://app.terraform.io"
  audiences = ["api://AzureADTokenExchange"]

  subject = join(":", [
    "organization", data.tfe_organization.current.name,
    "project", var.tfe_project_name,
    "workspace", tfe_workspace.this[each.value.workspace_short].name,
    "run_phase", each.value.run_phase
  ])
}

resource "azurerm_role_assignment" "write" {
  for_each             = toset(local.write_roles)
  role_definition_name = each.value

  principal_id = azuread_service_principal.hcp_terraform_write.object_id
  scope        = format("/subscriptions/%s", var.subscription_id)
}

resource "azurerm_role_assignment" "rbac" {
  for_each             = toset(local.rbac_roles)
  role_definition_name = each.value

  principal_id = azuread_service_principal.hcp_terraform_rbac.object_id
  scope        = format("/subscriptions/%s", var.subscription_id)
}

```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.7.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.7.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.60.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.60.0 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.110.0 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.110.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.74.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.7.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.60.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.74.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.hcp_terraform_rbac](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.hcp_terraform_write](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.hcp_rbac](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.hcp_write](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.hcp_terraform_rbac](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.hcp_terraform_write](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.write](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_variable.shared](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_azure_provider_auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_azure_run_client_id_rbac](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_azure_run_client_id_write](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable_set.shared](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) | resource |
| [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_variable_set.attach_shared](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set) | resource |
| [tfe_organization.current](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment short code. Allowed values: dev, uat, prd. | `string` | `"dev"` | no |
| <a name="input_long"></a> [long](#input\_long) | Long resource prefix used in naming (lowercase letters/numbers/hyphens). | `string` | `"libre-devops"` | no |
| <a name="input_long_region"></a> [long\_region](#input\_long\_region) | Long code for Azure region. Allowed values: uksouth, ukwest, westeurope. | `string` | `"uksouth"` | no |
| <a name="input_short"></a> [short](#input\_short) | Short resource prefix used in naming (lowercase letters/numbers/hyphens). | `string` | `"libd"` | no |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short code for Azure region. Allowed values: uks, ukw, euw. | `string` | `"uks"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure subscription ID (GUID) for the targeted subscription. | `string` | `"bf6128f4-93cb-45d4-bc13-7b3be2eea1c5"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure tenant ID (GUID). Typically passed as TF\_VAR. | `string` | `"01b9e453-84bc-4dc5-88de-a97a1fd42455"` | no |
| <a name="input_tfe_project_name"></a> [tfe\_project\_name](#input\_tfe\_project\_name) | The project name of the TFE project, normally passed as a TF\_VAR | `string` | `"libre-devops"` | no |

## Outputs

No outputs.
