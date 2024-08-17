output "workspace_id" {
  value = local.workspace_id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "resource_group_tags" {
  value = azurerm_resource_group.rg.tags
}
