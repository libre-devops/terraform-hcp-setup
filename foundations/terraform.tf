terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.110.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.74.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.60.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.7.0"
    }
  }
  cloud {
    organization = "example"
    workspaces {
      name = "example"
    }
  }
}

