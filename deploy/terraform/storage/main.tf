data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

resource "azurerm_storage_account" "images" {
  name                     = local.storage_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "images" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.images.name
  container_access_type = "container"
}