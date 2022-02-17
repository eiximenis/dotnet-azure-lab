data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

resource "azurerm_servicebus_namespace" "this" {
  name                = local.namespace
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
}

resource "azurerm_servicebus_topic" "this" {
  name         =  var.topic_name
  namespace_id = azurerm_servicebus_namespace.this.id
}

resource "azurerm_servicebus_subscription" "this" {
  name               = var.subscription_name
  topic_id           = azurerm_servicebus_topic.this.id
  max_delivery_count = 10
}