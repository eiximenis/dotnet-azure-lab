data "azurerm_resource_group" "rg" {
  name = var.resource_group
}


resource "azurerm_postgresql_server" "pgsql" {
  name                = local.pgsql_server_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  administrator_login          = "beers"
  administrator_login_password = var.pgsql_password

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}



resource "azurerm_postgresql_database" "beers" {
  name                = "beers"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.pgsql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "azure" {
  name                = "azure"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.pgsql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

data "http" "clientip" {
  url = "http://myexternalip.com/raw"
}

resource "azurerm_postgresql_firewall_rule" "client" {
  name                = "clientIp"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.pgsql.name
  start_ip_address    = data.http.clientip.body
  end_ip_address      = data.http.clientip.body
}
