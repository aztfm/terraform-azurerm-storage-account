resource "azurerm_resource_group" "env" {
  name     = local.workspace_id
  location = "Spain Central"
  tags = {
    "Origin"     = "GitHub"
    "Project"    = "Azure Terraform Modules (aztfm)"
    "Repository" = "terraform-azurerm-storage-account"
  }
}
