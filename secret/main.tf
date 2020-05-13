resource "azurerm_key_vault_secret" "secret" {
  name         = var.name
  value        = var.value
  key_vault_id = var.keyvault_id

  tags = {
    app = var.app_name
    env = var.env_name
  }
}