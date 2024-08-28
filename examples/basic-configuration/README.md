# Basic configuration

```hcl
module "storage_account" {
  source                   = "aztfm/storage-account/azurerm"
  version                  = "1.0.0"
  resource_group_name      = "resource-group"
  location                 = "Spain Central"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}
```
