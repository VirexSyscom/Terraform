terraform {
  backend "azurerm" {
    tenant_id       = "$(ATID)"
    client_id       = "$(ARMCID)"
    client_secret   = "$(ARMCSID)"
    subscription_id = "$(SID)"
    storage_account_name = "InfraDevOpsSA"
    container_name       = "InfraDevOpsContainer"
    key                  = "terraform.tfstate"
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