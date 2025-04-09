variable "resource_group_location" {
  type        = string
  default     = "japaneast"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "virex"
}

variable "SUBS_ID" {
  type        = string
  default     = "$(SUB_ID)"
}

variable "AZURE_TENANT_ID" {
  type        = string
  default     = "$(TENANT_ID)"
}

variable "AZURE_CLIENT_ID" {
  type        = string
  default     = "$(ARM_CLIENT_ID)"
}

variable "AZURE_CLIENT_SECRET" {
  type        = string
  default     = "$(ARM_CLIENT_SECRET_ID)"
}