
data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "beerskv"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "constr" {
  name         = "db-constr"
  value        = var.db_constr
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_user_assigned_identity" "uai" {
  count = var.create_uai ? 1 : 0
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  name                = "beersuai"
}

resource "azurerm_role_assignment" "uaireader" {
  count = var.create_uai ? 1 : 0
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.uai[0].id
}

resource "azurerm_key_vault_access_policy" "uaipolicy" {
  count = var.create_uai ? 1 : 0
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.uai[0].id

  key_permissions = [
    "Get","List",
  ]

  secret_permissions = [
    "Get","List",
  ]
}
