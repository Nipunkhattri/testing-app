output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_linux_web_app.app.id
}

output "app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_linux_web_app.app.name
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "The outbound IP addresses of the App Service"
  value       = azurerm_linux_web_app.app.outbound_ip_addresses
}

output "app_service_possible_outbound_ip_addresses" {
  description = "The possible outbound IP addresses of the App Service"
  value       = azurerm_linux_web_app.app.possible_outbound_ip_addresses
}

output "service_plan_id" {
  description = "The ID of the existing App Service Plan"
  value       = data.azurerm_service_plan.existing.id
}

output "service_plan_name" {
  description = "The name of the existing App Service Plan"
  value       = data.azurerm_service_plan.existing.name
}