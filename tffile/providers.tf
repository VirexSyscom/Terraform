terraform {
  backend "azurerm" {
    use_azuread_auth     = true                                    # Can also be set via `ARM_USE_AZUREAD` environment variable.
    tenant_id            = "$(TENANT_ID)"                          # Can also be set via `ARM_TENANT_ID` environment variable.
    client_id            = "$(ARM_CLIENT_ID)"                      # Can also be set via `ARM_CLIENT_ID` environment variable.
    client_secret        = "$(ARM_CLIENT_SECRET_ID)"               # Can also be set via `ARM_CLIENT_SECRET` environment variable.
    storage_account_name = "$(SAName)"                             # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "$(ContainerName)"                      # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "prod.terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
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