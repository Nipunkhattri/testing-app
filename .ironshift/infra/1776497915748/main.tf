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

data "azurerm_service_plan" "existing" {
  name                = "testing-app-plan"
  resource_group_name = "Deployment-Testing-RG"
}

resource "azurerm_linux_web_app" "app" {
  name                = "deployment-testing-app"
  location            = "Central India"
  resource_group_name = "Deployment-Testing-RG"
  service_plan_id     = data.azurerm_service_plan.existing.id

  site_config {
    always_on = false
    application_stack {
      node_version = "18-lts"
    }
  }
}