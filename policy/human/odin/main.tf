data "azurerm_client_config" "current" {}

data "azuread_user" "user_account" {
  user_principal_name = var.email_address
}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = var.keyvault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_user.user_account.object_id

  key_permissions = [
    "get", "list", "create", "update", "decrypt"
  ]

  secret_permissions = [
    "get", "list", "set", "purge", "recover", "delete"
  ]

}