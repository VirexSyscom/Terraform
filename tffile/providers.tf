terraform {
  backend "azurerm" {
    use_azuread_auth     = true                                    # Can also be set via `ARM_USE_AZUREAD` environment variable.
    tenant_id            = "virex.online"                          # Can also be set via `ARM_TENANT_ID` environment variable.
    client_id            = "a9653185-f78e-477c-acfe-cfb167f2ef20"  # Can also be set via `ARM_CLIENT_ID` environment variable.
    client_secret        = "$(ARM_SECRET)"                         # Can also be set via `ARM_CLIENT_SECRET` environment variable.
    resource_group_name  = "$(RG)"
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
