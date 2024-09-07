provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {
  account_tier               = "Standard"
  account_replication_type   = "ZRS"
  https_traffic_only_enabled = true
  containers = [{
    name                  = "container1"
    container_access_type = "private"
    }, {
    name                  = "container2"
    container_access_type = "blob"
  }]
  file_shares = [{
    name        = "fileshare1"
    quota_in_gb = 10
    }, {
    name        = "fileshare2"
    access_tier = "Cool"
    quota_in_gb = 20
  }]
}

run "plan" {
  command = plan

  variables {
    name                          = substr(replace(run.setup.workspace_id, "-", ""), 0, 24)
    resource_group_name           = run.setup.resource_group_name
    location                      = run.setup.resource_group_location
    tags                          = run.setup.resource_group_tags
    public_network_access_enabled = true
  }

  assert {
    condition     = azurerm_storage_account.main.name == substr(replace(run.setup.workspace_id, "-", ""), 0, 24)
    error_message = "The Storage Account name input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.resource_group_name == run.setup.resource_group_name
    error_message = "The Storage Account resource group input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.location == run.setup.resource_group_location
    error_message = "The Storage Account location input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.tags == run.setup.resource_group_tags
    error_message = "The Storage Account tags input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.account_tier == var.account_tier
    error_message = "The Storage Account tier input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.account_kind == "StorageV2"
    error_message = "The Storage Account kind input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.account_replication_type == var.account_replication_type
    error_message = "The Storage Account replication type input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.https_traffic_only_enabled == var.https_traffic_only_enabled
    error_message = "The Storage Account https traffic only enabled input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.min_tls_version == "TLS1_2"
    error_message = "The Storage Account min TLS version input variable is being modified."
  }

  assert {
    condition     = azurerm_storage_account.main.public_network_access_enabled == true
    error_message = "The Storage Account public network access enabled input variable is being modified."
  }

  assert {
    condition     = length(azurerm_storage_container.containers) == length(var.containers)
    error_message = "The number of Storage Account containers input variables is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[0].name].name == var.containers[0].name
    error_message = "The name of the first container is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[0].name].container_access_type == var.containers[0].container_access_type
    error_message = "The access type of the first container is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[1].name].name == var.containers[1].name
    error_message = "The name of the second container is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[1].name].container_access_type == var.containers[1].container_access_type
    error_message = "The access type of the second container is not as expected."
  }

  assert {
    condition     = length(azurerm_storage_share.file_shares) == length(var.file_shares)
    error_message = "The number of Storage Account file shares input variables is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[0].name].name == var.file_shares[0].name
    error_message = "The name of the first file share is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[0].name].access_tier == var.file_shares[0].access_tier
    error_message = "The access tier of the second file share is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[0].name].quota == var.file_shares[0].quota_in_gb
    error_message = "The quota of the first file share is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[1].name].name == var.file_shares[1].name
    error_message = "The name of the second file share is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[1].name].access_tier == var.file_shares[1].access_tier
    error_message = "The access tier of the second file share is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[1].name].quota == var.file_shares[1].quota_in_gb
    error_message = "The quota of the second file share is not as expected."
  }
}

run "apply" {
  command = apply

  variables {
    name                = substr(replace(run.setup.workspace_id, "-", ""), 0, 24)
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tags                = run.setup.resource_group_tags
  }

  assert {
    condition     = azurerm_storage_account.main.id == "${run.setup.resource_group_id}/providers/Microsoft.Storage/storageAccounts/${substr(replace(run.setup.workspace_id, "-", ""), 0, 24)}"
    error_message = "The Storage Account ID is not as expected."
  }

  assert {
    condition     = azurerm_storage_account.main.name == substr(replace(run.setup.workspace_id, "-", ""), 0, 24)
    error_message = "The Storage Account name is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[0].name].resource_manager_id == "${azurerm_storage_account.main.id}/blobServices/default/containers/${var.containers[0].name}"
    error_message = "The first container's Storage Account ID is not as expected."
  }

  assert {
    condition     = azurerm_storage_container.containers[var.containers[1].name].resource_manager_id == "${azurerm_storage_account.main.id}/blobServices/default/containers/${var.containers[1].name}"
    error_message = "The first container's Storage Account ID is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[0].name].resource_manager_id == "${azurerm_storage_account.main.id}/fileServices/default/fileshares/${var.file_shares[0].name}"
    error_message = "The first file share's Storage Account ID is not as expected."
  }

  assert {
    condition     = azurerm_storage_share.file_shares[var.file_shares[1].name].resource_manager_id == "${azurerm_storage_account.main.id}/fileServices/default/fileshares/${var.file_shares[1].name}"
    error_message = "The second file share's Storage Account ID is not as expected."
  }

  assert {
    condition     = output.id == azurerm_storage_account.main.id
    error_message = "The Storage Account ID output is not as expected."
  }

  assert {
    condition     = output.name == azurerm_storage_account.main.name
    error_message = "The Storage Account name output is not as expected."
  }

  assert {
    condition     = output.resource_group_name == azurerm_storage_account.main.resource_group_name
    error_message = "The Storage Account resource group name output is not as expected."
  }

  assert {
    condition     = output.location == azurerm_storage_account.main.location
    error_message = "The Storage Account location output is not as expected."
  }

  assert {
    condition     = output.tags == azurerm_storage_account.main.tags
    error_message = "The Storage Account tags output is not as expected."
  }

  assert {
    condition     = output.containers == azurerm_storage_container.containers
    error_message = "The Storage Account containers output is not as expected."
  }

  assert {
    condition     = output.file_shares == azurerm_storage_share.file_shares
    error_message = "The Storage Account file shares output is not as expected."
  }
}
