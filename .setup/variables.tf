variable "env" {
  type        = string
  description = "Environment short code. Allowed values: dev, uat, prd."
  nullable    = false

  validation {
    condition     = contains(["dev", "uat", "prd"], lower(trimspace(var.env)))
    error_message = "env must be one of: dev, uat, prd (case-insensitive)."
  }
}

variable "long" {
  type        = string
  description = "Long resource prefix used in naming (lowercase letters/numbers/hyphens)."
  nullable    = false

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{0,22}[a-z0-9]$", lower(trimspace(var.long))))
    error_message = "long must be 2–24 chars, lowercase a-z/0-9/hyphen, start and end with a letter or number."
  }
}

variable "long_region" {
  type        = string
  description = "Short code for Azure region. Allowed values: uks, ukw, euw."
  nullable    = false

  validation {
    condition     = contains(["uksouth", "ukwest", "westeurope"], lower(trimspace(var.long_region)))
    error_message = "lonh_region must be one of: uksouth, ukwest, westeurope (case-insensitive)."
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

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", lower(trimspace(var.subscription_id))))
    error_message = "subscription_id must be a valid GUID in the form xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx."
  }
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID (GUID). Typically passed as TF_VAR."
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", lower(trimspace(var.tenant_id))))
    error_message = "tenant_id must be a valid GUID in the form xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx."
  }
}

variable "tfe_project_name" {
  type        = string
  description = "The project name of the TFE project, normally passed as a TF_VAR"
  nullable    = false

  validation {
    condition     = length(trimspace(var.tfe_project_name)) > 0
    error_message = "tfe_project_name must not be empty."
  }
}
