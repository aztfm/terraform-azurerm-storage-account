provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {

}

run "plan" {
  command = plan

  assert {
    condition     = azurerm_
    error_message = ""
  }
}

run "apply" {
  command = apply

  assert {
    condition     = azurerm_
    error_message = ""
  }

  // assert {
  //   condition     = output.
  //   error_message = ""
  // }
}
