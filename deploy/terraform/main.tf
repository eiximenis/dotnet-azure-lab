
### Initial Scenario: storage + pgsql + appsvc

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
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
  key_vault_url = var.scenario > 1 ?  module.keyvault[0].kv_url : null
  uai = var.scenario > 1 ? module.keyvault[0].uai_id : null
}

### Scenario 2: Adding keyvault

module "keyvault" {
  count =  var.scenario > 1 ? 1 : 0
  source         = "./keyvault"
  resource_group = azurerm_resource_group.rg.name
  db_constr      = module.pgsql.constr
  depends_on = [
    azurerm_resource_group.rg
  ]
}

### Scenario 3: Adding servicebus and functionapp 

module "servicebus" {
  count = var.scenario > 2 ? 1 :0
  source         = "./servicebus"
  resource_group = azurerm_resource_group.rg.name
  topic_name = "purchases"
  subscription_name = "main"
}

module "functionapp" {
  count = var.scenario > 2 ? 1 :0
  source         = "./functionapp"
  resource_group = azurerm_resource_group.rg.name
  servicebus_constr = module.servicebus[0].servicebus_primary_constr
}


