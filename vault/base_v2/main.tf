data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    /*
    default_action = "Deny"
    */
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {
    app = var.app_name
    env = var.env_name
  }
}

resource "azurerm_monitor_diagnostic_setting" "keyvault_diagnostic_setting" {

  name                        = "${var.name}-keyvault-logs"
  target_resource_id          = azurerm_key_vault.keyvault.id
  log_analytics_workspace_id  = var.loganalytics_workspace_id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}
