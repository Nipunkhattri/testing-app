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
  default     = "centralindia"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "deployment-testing-plan"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "deployment-testing-app"
}

variable "os_type" {
  description = "Operating system type for App Service Plan"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "SKU name for App Service Plan"
  type        = string
  default     = "B1"
}

variable "runtime_stack" {
  description = "Runtime stack for the application"
  type        = string
  default     = "NODE"
}

variable "runtime_version" {
  description = "Runtime version for Node.js"
  type        = string
  default     = "18-lts"
}

variable "always_on" {
  description = "Enable always on feature"
  type        = bool
  default     = false
}