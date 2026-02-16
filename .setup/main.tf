locals {
  stack_name      = "libre-devops-platform"
  deployment_name = var.env
  run_phases      = toset(["plan", "apply"])

  fic_bindings = {
  for phase in local.run_phases :
  "stack-${phase}" => {
    operation = phase
  }
}


  workspaces = toset(["foundation", "automation", "integration"])

  shared_vars = {
    env              = var.env
    short_region     = var.short_region
    long_region      = var.long_region
    tenant_id        = var.tenant_id
    subscription_id  = var.subscription_id
    long             = var.long
    short            = var.short
    tfe_project_name = var.tfe_project_name
    write_client_id  = azuread_service_principal.hcp_terraform_write.client_id
    write_object_id  = azuread_service_principal.hcp_terraform_write.object_id
    rbac_client_id   = azuread_service_principal.hcp_terraform_rbac.client_id
    rbac_object_id   = azuread_service_principal.hcp_terraform_rbac.object_id
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

  key       = each.key
  value     = each.value
  category  = "terraform"
  sensitive = false
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

  display_name = "hcp-write-${var.env}-${each.value.operation}"

  issuer    = "https://app.terraform.io"
  audiences = ["api://AzureADTokenExchange"]

  subject = "organization:${data.tfe_organization.current.name}:project:${var.tfe_project_name}:stack:${local.stack_name}:deployment:${local.deployment_name}:operation:${each.value.operation}"
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

  display_name = "hcp-rbac-${var.env}-${each.value.operation}"

  issuer    = "https://app.terraform.io"
  audiences = ["api://AzureADTokenExchange"]

  subject = "organization:${data.tfe_organization.current.name}:project:${var.tfe_project_name}:stack:${local.stack_name}:deployment:${local.deployment_name}:operation:${each.value.operation}"
}


resource "azurerm_role_assignment" "write" {
  for_each             = toset(local.write_roles)
  role_definition_name = each.value
  principal_id         = azuread_service_principal.hcp_terraform_write.object_id
  scope                = format("/subscriptions/%s", var.subscription_id)
}

resource "azurerm_role_assignment" "rbac" {
  for_each             = toset(local.rbac_roles)
  role_definition_name = each.value
  principal_id         = azuread_service_principal.hcp_terraform_rbac.object_id
  scope                = format("/subscriptions/%s", var.subscription_id)
}
