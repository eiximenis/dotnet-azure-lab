output "images_url" {
  value = "${azurerm_storage_account.images.primary_blob_endpoint}/images"
}