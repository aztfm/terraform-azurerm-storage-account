provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}

run "plan" {
  command = plan

  variables {
    name                = run.setup.workspace_id
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tags                = run.setup.resource_group_tags
  }

  assert {
    condition     = azurerm_storage_account.main.name == run.setup.workspace_id
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
    condition     = azurerm_storage_account.main.account_replication_type == var.account_replication_type
    error_message = "The Storage Account replication type input variable is being modified."
  }
}

run "apply" {
  command = apply

  variables {
    name                = run.setup.workspace_id
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tags                = run.setup.resource_group_tags
  }

  assert {
    condition     = azurerm_storage_account.main.id == "${run.setup.resource_group_id}/providers/Microsoft.Network/storageAccounts/${run.setup.workspace_id}"
    error_message = "The Storage Account ID is not as expected."
  }
}
