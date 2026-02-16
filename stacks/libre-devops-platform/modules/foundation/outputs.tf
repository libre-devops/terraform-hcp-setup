output "rg_foundation_name" {
  description = "foundation resource group name."
  value       = azurerm_resource_group.foundation.name
}

output "rg_foundation_id" {
  description = "foundation resource group ID."
  value       = azurerm_resource_group.foundation.id
}

output "rg_foundation_location" {
  description = "foundation resource group location."
  value       = azurerm_resource_group.foundation.location
}

output "rg_networking_name" {
  description = "Networking resource group name (created by foundation)."
  value       = azurerm_resource_group.networking.name
}

output "rg_networking_id" {
  description = "Networking resource group ID (created by foundation)."
  value       = azurerm_resource_group.networking.id
}

output "rg_networking_location" {
  description = "Networking resource group location (created by foundation)."
  value       = azurerm_resource_group.networking.location
}

output "rg_automation_standard_name" {
  description = "Automation Standard resource group name (created by foundation)."
  value       = azurerm_resource_group.automation_standard.name
}

output "rg_automation_standard_id" {
  description = "Automation Standard resource group ID (created by foundation)."
  value       = azurerm_resource_group.automation_standard.id
}

output "rg_automation_standard_location" {
  description = "Automation Standard resource group location (created by foundation)."
  value       = azurerm_resource_group.automation_standard.location
}

output "rg_automation_privileged_name" {
  description = "Automation Privileged resource group name (created by foundation)."
  value       = azurerm_resource_group.automation_privileged.name
}

output "rg_automation_privileged_id" {
  description = "Automation Privileged resource group ID (created by foundation)."
  value       = azurerm_resource_group.automation_privileged.id
}

output "rg_automation_privileged_location" {
  description = "Automation Privileged resource group location (created by foundation)."
  value       = azurerm_resource_group.automation_privileged.location
}

output "rg_alerting_name" {
  description = "Alerting resource group name (created by foundation)."
  value       = azurerm_resource_group.alerting.name
}

output "rg_alerting_id" {
  description = "Alerting resource group ID (created by foundation)."
  value       = azurerm_resource_group.alerting.id
}

output "rg_alerting_location" {
  description = "Alerting resource group location (created by foundation)."
  value       = azurerm_resource_group.alerting.location
}

output "rg_sentinel_name" {
  description = "Sentinel resource group name (created by foundation)."
  value       = azurerm_resource_group.sentinel.name
}

output "rg_sentinel_id" {
  description = "Sentinel resource group ID (created by foundation)."
  value       = azurerm_resource_group.sentinel.id
}

output "rg_sentinel_location" {
  description = "Sentinel resource group location (created by foundation)."
  value       = azurerm_resource_group.sentinel.location
}

output "rg_integration_name" {
  description = "Integration resource group name (created by foundation)."
  value       = azurerm_resource_group.integration.name
}

output "rg_integration_id" {
  description = "Integration resource group ID (created by foundation)."
  value       = azurerm_resource_group.integration.id
}

output "rg_integration_location" {
  description = "Integration resource group location (created by foundation)."
  value       = azurerm_resource_group.integration.location
}

# Back-compat (previous output names). Consider removing once callers migrate.
output "rg_automation_name" {
  description = "DEPRECATED: use rg_automation_standard_name."
  value       = azurerm_resource_group.automation_standard.name
}

output "rg_automation_id" {
  description = "DEPRECATED: use rg_automation_standard_id."
  value       = azurerm_resource_group.automation_standard.id
}

output "rg_automation_location" {
  description = "DEPRECATED: use rg_automation_standard_location."
  value       = azurerm_resource_group.automation_standard.location
}

output "foundation_uai_name" {
  description = "foundation user-assigned identity name."
  value       = azurerm_user_assigned_identity.this.name
}

output "foundation_uai_id" {
  description = "foundation user-assigned identity resource ID."
  value       = azurerm_user_assigned_identity.this.id
}

output "foundation_uai_client_id" {
  description = "foundation user-assigned identity client ID."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "foundation_uai_principal_id" {
  description = "foundation user-assigned identity principal ID."
  value       = azurerm_user_assigned_identity.this.principal_id
}