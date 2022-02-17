data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

resource "azurerm_storage_account" "this" {
  name                     = local.storage_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_app_service_plan" "this" {
  name                = local.svcplan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
  
}

resource "azurerm_function_app" "this" {
  name                       = local.functionapp_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  app_settings = {
    "ServiceBusConnection" = var.servicebus_constr
  }

  site_config {
    dotnet_framework_version = "v6.0"
    scm_type                 = "None"
  }
}