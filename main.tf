terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
   }

#  backend "azurerm" {
#    resource_group_name  = "patricksdemostorage"
#    storage_account_name = "patricksdemostorage"
#    container_name       = "blogtfstate"
#    key                  = "acr.demo.tfstate"
#  }

 # required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}"
  location = "westeurope"
}

resource "azurerm_container_registry" "acr_demo" {
  name                = "${replace(var.project_name, "_", "")}containerregistry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}