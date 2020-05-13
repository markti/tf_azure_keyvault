data "azurerm_client_config" "current" {}

data "azuread_group" "user_group" {
  object_id = var.group_id
}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = var.keyvault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.user_group.object_id

  key_permissions = [
    "list"
  ]

  secret_permissions = [
    "list"
  ]

}