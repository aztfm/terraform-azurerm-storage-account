# Azure Storage Account - Terraform Module

[devcontainer]: https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/aztfm/terraform-azurerm-storage-account
[registry]: https://registry.terraform.io/modules/aztfm/storage-account/azurerm/

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blueviolet?logo=terraform&logoColor=white)][registry]
[![Dev Container](https://img.shields.io/badge/DevContainer-Open_with_VSCode-blue?logo=linuxcontainers)][devcontainer]
![GitHub License](https://img.shields.io/github/license/aztfm/terraform-azurerm-storage-account)
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
| ---- | ----------- | :--: | :-----: | :------: |
|name|The name of the Storage Account.|`string`|n/a|yes|
|resource\_group\_name|The name of the resource group in which to create the Storage Account.|`string`|n/a|yes|
|location|The location/region where the Storage Account is created.|`string`|n/a|yes|
|tags|A mapping of tags to assign to the resource.|`map(string)`|`{}`|no|
|account\_tier|Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`.|`string`|n/a|yes|
|account\_kind|Defines the Kind to use for this storage account. Valid options are `Storage`, `StorageV2`, `BlobStorage`, `FileStorage`, `BlockBlobStorage`.|`string`|`"StorageV2"`|no|
|account\_replication\_type|Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Changing this forces a new resource to be created when types `LRS`, `GRS` and `RAGRS` are changed to `ZRS`, `GZRS` or `RAGZRS` and vice versa.|`string`|n/a|yes|
|https\_traffic\_only\_enabled|Allows https traffic only to storage service if set to true.|`bool`|`true`|no|
|min\_tls\_version|The minimum supported TLS version for the storage account. Valid values are `TLS1_0`, `TLS1_1`, `TLS1_2`.|`string`|`"TLS1_2"`|no|
|public\_network\_access\_enabled|Controls whether data on the public internet is allowed to be read or written to the storage account.|`bool`|`true`|no|
|containers|A list of containers to create within the Storage Account.|`list(object({}))`|`[]`|no|
|file\_shares|A list of file shares to create within the Storage Account.|`list(object({}))`|`[]`|no|

The `containers` supports the next parameters:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|name|The name of the Container which should be created within the Storage Account|`string`|n/a|yes|
|container\_access\_type|The Access Level configured for this Container. Possible values are `blob`, `container` and `private`.|`string`|`private`|no|

The `file_shares` supports the next parameters:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|name|The name of the File Share which should be created within the Storage Account|`string`|n/a|yes|
|access\_tier|The Access Tier configured for this File Share. Possible values are `Hot`, `Cool`, `TransactionOptimized` and `Premium`.|`string`|`Hot`|no|
|quota\_in\_gb|The maximum size of the File Share in GB. This must be between `1` and `5120` GB inclusive|`integer`|n/a|yes|

## :arrow_backward: Outputs

The module supports the next outputs:

| Name | Description | Sensitive |
| ---- | ----------- | :-------: |
|id|The ID of the Storage Account.|no|
|name|The name of the Storage Account.|no|
|resource_group_name|The resource group name of the Storage Account.|no|
|location|The location of the Storage Account.|no|
|tags|The tags of the Storage Account.|no|
|containers|The containers within the Storage Account.|no|
|file_shares|The file shares within the Storage Account.|no|
<!-- END_TF_DOCS -->
