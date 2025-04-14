terraform {
  backend "azurerm" {
    tenant_id            = "$(TENANT_ID)"
    client_id            = "$(ARM_CLIENT_ID)"
    client_secret        = "$(ARM_CLIENT_SECRET_ID)"
    subscription_id      = "$(SUB_ID)"
    storage_account_name = "$(SAName)"
    container_name       = "$(ContainerName)"
    key                  = "terraform.tfstate"
    use_oidc             = true
    use_azuread_auth     = true
  }
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm"{
  features {}
}