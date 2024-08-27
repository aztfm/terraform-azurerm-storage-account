# Azure Storage Account - Terraform Module

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blueviolet.svg)](https://registry.terraform.io/modules/aztfm/storage-account/azurerm/)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-storage-account)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/aztfm/terraform-azurerm-storage-account?quickstart=1)

## :gear: Version compatibility

| Module version | Terraform version | hashicorp/azurerm version|
| -------------- | ----------------- | ------------------------ |
| >= 1.0.0       | >= 1.9.x          | ~>4.0                    |

## :memo: Usage

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "resource-group"
  location = "Spain Central"
}

module "storage_account" {
  source                   = "aztfm/storage-account/azurerm"
  version                  = ">=1.0.0"
  name                     = "storageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}
```

Reference to more [examples](https://github.com/aztfm/terraform-azurerm-storage-account/tree/main/examples).

<!-- BEGIN_TF_DOCS -->
## :arrow_forward: Parameters

The module supports the next parameters:

| Name | Description | Type | Default | Required |
| ------ | ----------- | :--: | :---------------: | :-------: |
|name|The name of the Storage Account.|`string`|n/a|yes|
|resource\_group\_name|The name of the resource group in which to create the Storage Account.|`string`|n/a|yes|
|location|The location/region where the Storage Account is created.|`string`|n/a|yes|
|tags|A mapping of tags to assign to the resource.|`map(string)`|`{}`|no|
|account\_tier|Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`.|`string`|n/a|yes|
|account\_kind|Defines the Kind to use for this storage account. Valid options are `Storage`, `StorageV2`, `BlobStorage`, `FileStorage`, `BlockBlobStorage`.|`string`|`"StorageV2"`|no|
|account\_replication\_type|Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Changing this forces a new resource to be created when types `LRS`, `GRS` and `RAGRS` are changed to `ZRS`, `GZRS` or `RAGZRS` and vice versa.|`string`|n/a|yes|
|https\_traffic\_only\_enabled|Allows https traffic only to storage service if set to true.|`bool`|`false`|no|
|public\_network\_access\_enabled|Controls whether data on the public internet is allowed to be read or written to the storage account.|`bool`|`true`|no|

`example1` supports the next parameters:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|example||`string`|n/a|yes|

`example2` supports the next parameters:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|example||`string`|n/a|yes|

## :arrow_backward: Outputs

The module supports the next outputs:

| Name | Description | Sensitive |
| ---- | ----------- | :-------: |
|id|The ID of the Storage Account.|no|
|name|The name of the Storage Account.|no|
|resource_group_name|The resource group name of the Storage Account.|no|
|location|The location of the Storage Account.|no|
|tags|The tags of the Storage Account.|no|
<!-- END_TF_DOCS -->
