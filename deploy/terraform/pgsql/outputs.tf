output "constr" {
  value = "Host=${azurerm_postgresql_server.pgsql.fqdn};Database=beers;Username=beers@${azurerm_postgresql_server.pgsql.fqdn};Password=${var.pgsql_password};SSLMode=Prefer"
}