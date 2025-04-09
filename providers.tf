terraform {
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

provider "azurerm" {
  tenant_id       = var.Tenant_ID
  client_id       = var.ARM_Client_ID
  client_secret   = var.ARM_Client_Secret_ID
  subscription_id = var.Subscription_ID
  features {}
}