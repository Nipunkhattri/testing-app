output "resource_group_name" {
  description = "The name of the resource group"
  value       = data.azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = data.azurerm_resource_group.main.location
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan"
  value       = azurerm_service_plan.main.name
}

output "app_service_plan_location" {
  description = "The location of the App Service Plan"
  value       = azurerm_service_plan.main.location
}

output "app_service_plan_sku" {
  description = "The SKU of the App Service Plan"
  value       = azurerm_service_plan.main.sku_name
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_linux_web_app.main.id
}

output "app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_linux_web_app.main.name
}

output "app_service_location" {
  description = "The location of the App Service"
  value       = azurerm_linux_web_app.main.location
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_linux_web_app.main.default_hostname
}

output "app_service_url" {
  description = "The URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "app_service_outbound_ip_addresses" {
  description = "The outbound IP addresses of the App Service"
  value       = azurerm_linux_web_app.main.outbound_ip_addresses
}

output "app_service_possible_outbound_ip_addresses" {
  description = "The possible outbound IP addresses of the App Service"
  value       = azurerm_linux_web_app.main.possible_outbound_ip_addresses
}