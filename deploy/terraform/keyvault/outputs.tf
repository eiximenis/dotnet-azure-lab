output "kv_id" {
    value = azurerm_key_vault.kv.id
}

output "kv_url" {
    value = azurerm_key_vault.kv.vault_uri
}

output "uai_principal_id" {
    value = var.create_uai ? azurerm_user_assigned_identity.uai[0].id : null
}

