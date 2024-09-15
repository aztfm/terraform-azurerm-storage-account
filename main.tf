resource "azurerm_storage_account" "main" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags
  account_tier                  = var.account_tier
  account_kind                  = var.account_kind
  account_replication_type      = var.account_replication_type
  https_traffic_only_enabled    = var.https_traffic_only_enabled
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [""] : []

    content {
      default_action             = "Deny"
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
      ip_rules                   = network_rules.value.ip_rules
      bypass                     = network_rules.value.bypass
    }
  }
}

resource "azurerm_storage_container" "containers" {
  for_each              = { for container in var.containers : container.name => container }
  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = each.value.container_access_type
}

resource "azurerm_storage_share" "file_shares" {
  for_each             = { for share in var.file_shares : share.name => share }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.main.name
  access_tier          = each.value.access_tier
  quota                = each.value.quota_in_gb
}
