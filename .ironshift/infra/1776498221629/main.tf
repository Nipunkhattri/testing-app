terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a66db4d1-4b92-4c2d-830b-341a8c0b5482"
}

data "azurerm_resource_group" "main" {
  name = "Deployment-Testing-RG"
}

resource "azurerm_service_plan" "main" {
  name                = "deployment-testing-plan"
  location            = "centralindia"
  resource_group_name = data.azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "deployment-testing-app"
  location            = "centralindia"
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = false
    application_stack {
      node_version = "18-lts"
    }
  }
}