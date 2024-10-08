output "id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the Storage Account."
}

output "name" {
  value       = azurerm_storage_account.main.name
  description = "The name of the Storage Account."
}

output "resource_group_name" {
  value       = azurerm_storage_account.main.resource_group_name
  description = "The resource group name of the Storage Account."
}

output "location" {
  value       = azurerm_storage_account.main.location
  description = "The location of the Storage Account."
}

output "tags" {
  value       = azurerm_storage_account.main.tags
  description = "The tags of the Storage Account."
}

output "containers" {
  value       = { for container in azurerm_storage_container.containers : container.name => container }
  description = "The containers within the Storage Account."
  # module.MODULE_NAME.containers["CONTAINER_NAME"].id
}

output "file_shares" {
  value       = { for file_share in azurerm_storage_share.file_shares : file_share.name => file_share }
  description = "The file shares within the Storage Account."
  # module.MODULE_NAME.file_shares["FILE_SHARE_NAME"].id  
}
