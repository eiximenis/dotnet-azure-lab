output "api_appsvc_id" {
    value = azurerm_app_service.api.id
}

output "api_appsvc_url" {
    value = "https://${azurerm_app_service.api.default_site_hostname}"
}

output "web_appsvc_id" {
    value = azurerm_app_service.web.id
}

output "web_appsvc_url" {
    value = "https://${azurerm_app_service.web.default_site_hostname}"
}