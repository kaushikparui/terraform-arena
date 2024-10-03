# Terraform Dependencies
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  #subscription_id = var.subscription_id
  #tenant_id       = var.tenant_id
  features {}
}