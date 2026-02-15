output "rg_foundations_name" {
  description = "Foundations resource group name."
  value       = azurerm_resource_group.foundations.name
}

output "rg_foundations_id" {
  description = "Foundations resource group ID."
  value       = azurerm_resource_group.foundations.id
}

output "rg_foundations_location" {
  description = "Foundations resource group location."
  value       = azurerm_resource_group.foundations.location
}

output "rg_automation_name" {
  description = "Automation resource group name (created by foundations)."
  value       = azurerm_resource_group.automation.name
}

output "rg_automation_id" {
  description = "Automation resource group ID (created by foundations)."
  value       = azurerm_resource_group.automation.id
}

output "rg_automation_location" {
  description = "Automation resource group location (created by foundations)."
  value       = azurerm_resource_group.automation.location
}

output "rg_integration_name" {
  description = "Integration resource group name (created by foundations)."
  value       = azurerm_resource_group.integration.name
}

output "rg_integration_id" {
  description = "Integration resource group ID (created by foundations)."
  value       = azurerm_resource_group.integration.id
}

output "rg_integration_location" {
  description = "Integration resource group location (created by foundations)."
  value       = azurerm_resource_group.integration.location
}

output "foundations_uai_name" {
  description = "Foundations user-assigned identity name."
  value       = azurerm_user_assigned_identity.this.name
}

output "foundations_uai_id" {
  description = "Foundations user-assigned identity resource ID."
  value       = azurerm_user_assigned_identity.this.id
}

output "foundations_uai_client_id" {
  description = "Foundations user-assigned identity client ID."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "foundations_uai_principal_id" {
  description = "Foundations user-assigned identity principal ID."
  value       = azurerm_user_assigned_identity.this.principal_id
}