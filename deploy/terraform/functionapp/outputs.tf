output "functionapp_id" {
    value = azurerm_function_app.this.id
}

output "functionapp_hostname" {
    value = azurerm_function_app.this.default_hostname
}