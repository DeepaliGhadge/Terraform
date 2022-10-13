resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate1" {
  name     = "tfstate1"
  location = "Central India"
}

resource "azurerm_storage_account" "tfstate1" {
  name                     = "tfstate1${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfstate1.name
  location                 = azurerm_resource_group.tfstate1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate1" {
  name                  = "tfstate1"
  storage_account_name  = azurerm_storage_account.tfstate1.name
  container_access_type = "blob"
}