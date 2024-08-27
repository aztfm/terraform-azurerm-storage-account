resource "azurerm_storage_account" "main" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags
  account_tier                  = var.account_tier
  account_kind                  = var.account_kind
  account_replication_type      = var.account_replication_type
  https_traffic_only_enabled    = var.https_traffic_only_enabled
  public_network_access_enabled = var.public_network_access_enabled
}
