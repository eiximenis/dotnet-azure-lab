data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

###############################################
# API
###############################################
resource "azurerm_app_service_plan" "api" {
  name                = "api-serviceplan"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "api" {
  name                = local.api_appsvc_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.api.id

  site_config {
    dotnet_framework_version = "v6.0"
    scm_type                 = "None"
  }

  connection_string {
    name  = "beers"
    type  = "PostgreSQL"
    value = var.db_constr
  }
}

###############################################
# WEB
###############################################
resource "azurerm_app_service_plan" "web" {
  name                = "web-serviceplan"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "web" {
  name                = local.web_appsvc_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.api.id

  site_config {
    dotnet_framework_version = "v6.0"
    scm_type                 = "None"
  }

  app_settings = {
    "API__URL" = azurerm_app_service.api.default_site_hostname
    "IMAGES__URL" = var.url_images
  }


}