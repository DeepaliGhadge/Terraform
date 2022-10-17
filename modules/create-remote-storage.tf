resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstatebonus" {
  name     = "tfstatebonus"
  location = "Central India"
}

resource "azurerm_storage_account" "tfstatebonus" {
  name                     = "tfstatebonus${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfstatebonus.name
  location                 = azurerm_resource_group.tfstatebonus.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstatebonus" {
  name                  = "tfstatebonus"
  storage_account_name  = azurerm_storage_account.tfstatebonus.name
  container_access_type = "blob"
}