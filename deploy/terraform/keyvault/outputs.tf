output "kv_id" {
    value = azurerm_key_vault.kv.id
}

output "kv_url" {
    value = azurerm_key_vault.kv.vault_uri
}

output "uai_principal_id" {
    value =  azurerm_user_assigned_identity.uai.principal_id 
}

output "uai_id" {
    value =  azurerm_user_assigned_identity.uai.id 
}

