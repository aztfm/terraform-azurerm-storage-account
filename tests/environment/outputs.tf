output "workspace_id" {
  value = local.workspace_id
}

output "resource_group_id" {
  value = azurerm_resource_group.env.id
}

output "resource_group_name" {
  value = azurerm_resource_group.env.name
}

output "resource_group_location" {
  value = azurerm_resource_group.env.location
}

output "resource_group_tags" {
  value = azurerm_resource_group.env.tags
}
