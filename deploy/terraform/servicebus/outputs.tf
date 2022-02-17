
output "servicebus_namespace" {
    value = local.namespace
}

output "servicebus_primary_key" {
    value = azurerm_servicebus_namespace.this.default_primary_key
}

output "servicebus_primary_constr" {
    value = azurerm_servicebus_namespace.this.default_primary_connection_string
}