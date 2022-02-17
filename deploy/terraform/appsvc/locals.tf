resource "random_id" "server" {
  keepers = {
    ami_id = "${var.resource_group}"
  }
  byte_length = 8
}


locals {
    api_appsvc_name = "beersapi${random_id.server.hex}"
    web_appsvc_name = "beersweb${random_id.server.hex}"
    use_managed_identity = var.uai != null ? true : false 
    use_keyvault = var.key_vault_url != null ? true : false
    connection_strings = local.use_keyvault ? [] : [{key = "1", name = "beers", type = "Custom", value = var.db_constr}]
}