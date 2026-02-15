variable "env" {
  type        = string
  description = "Environment short code. Allowed values: dev, uat, prd."
  nullable    = false

  validation {
    condition     = contains(["dev", "uat", "prd"], lower(trimspace(var.env)))
    error_message = "env must be one of: dev, uat, prd (case-insensitive)."
  }
}

variable "layer_name" {
  type        = string
  description = "The layer name of this terraform run"
  nullable    = false

  validation {
    condition     = contains(["foundations", "automation", "integration"], lower(trimspace(var.layer_name)))
    error_message = "layer_name must be one of: foundations, automation, integration (case-insensitive)."
  }
}

variable "long_region" {
  type        = string
  description = "Long code for Azure region. Allowed values: uksouth, ukwest, westeurope."
  nullable    = false

  validation {
    condition     = contains(["uksouth", "ukwesty", "westeurope"], lower(trimspace(var.long_region)))
    error_message = "lonh_region must be one of: uksouth, ukwest, westeurope (case-insensitive)."
  }
}

variable "rbac_client_id" {
  type        = string
  description = "Client ID for the RBAC Service Principal used by the azurerm.rbac provider alias."
  nullable    = false
  ephemeral   = true

  validation {
    condition     = length(trimspace(var.rbac_client_id)) > 0
    error_message = "rbac_client_id must not be empty."
  }
}

variable "short" {
  type        = string
  description = "Short resource prefix used in naming (lowercase letters/numbers/hyphens)."
  nullable    = false

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{0,22}[a-z0-9]$", lower(trimspace(var.short))))
    error_message = "short must be 2–24 chars, lowercase a-z/0-9/hyphen, start and end with a letter or number."
  }
}

variable "short_region" {
  type        = string
  description = "Short code for Azure region. Allowed values: uks, ukw, euw."
  nullable    = false

  validation {
    condition     = contains(["uks", "ukw", "euw"], lower(trimspace(var.short_region)))
    error_message = "short_region must be one of: uks, ukw, euw (case-insensitive)."
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID (GUID) for the targeted subscription."
  nullable    = false
  ephemeral   = true

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", lower(trimspace(var.subscription_id))))
    error_message = "subscription_id must be a valid GUID in the form xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx."
  }
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID (GUID). Typically passed as TF_VAR."
  nullable    = false
  ephemeral   = true

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", lower(trimspace(var.tenant_id))))
    error_message = "tenant_id must be a valid GUID in the form xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx."
  }
}

variable "resource_group_name" {
  type = string
  description = "The resource group name to place resources in"
}

variable "resource_group_id" {
  type = string
  description = "The resource group id to place resources in"
}

variable "location" {
  type = string
  description = "The location for the resources, passed from resource group output"
}