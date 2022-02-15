


resource "azurerm_resource_group" "rg" {
  name     = "beers"
  location = "West Europe"
}

module "storage" {
  source         = "./storage"
  resource_group = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "pgsql" {
  source         = "./pgsql"
  resource_group = azurerm_resource_group.rg.name
  pgsql_password = var.pgsql_password
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "appsvc" {
  source         = "./appsvc"
  resource_group = azurerm_resource_group.rg.name
  url_images     = module.storage.images_url
  db_constr      = module.pgsql.constr
  depends_on = [
    azurerm_resource_group.rg
  ]
}



