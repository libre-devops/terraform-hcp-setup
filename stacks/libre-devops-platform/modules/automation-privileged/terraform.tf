terraform {
  required_providers {
    azurerm = {
      configuration_aliases = [azurerm.rbac]
      source                = "hashicorp/azurerm"
      version               = "~> 4.60.0"
    }
  }
  cloud {
    organization = "example"
    workspaces {
      name = "example"

    }
  }
}

