variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "a66db4d1-4b92-4c2d-830b-341a8c0b5482"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "Deployment-Testing-RG"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Central India"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "deployment-testing-app"
}

variable "app_service_plan_name" {
  description = "Name of the existing App Service Plan"
  type        = string
  default     = "testing-app-plan"
}

variable "runtime_stack" {
  description = "Runtime stack for the App Service"
  type        = string
  default     = "NODE"
}

variable "runtime_version" {
  description = "Runtime version for Node.js"
  type        = string
  default     = "18-lts"
}

variable "always_on" {
  description = "Enable always on for the App Service"
  type        = bool
  default     = false
}

variable "use_existing_plan" {
  description = "Flag to indicate using existing App Service Plan"
  type        = bool
  default     = true
}