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
}
