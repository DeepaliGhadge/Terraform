resource "azurerm_postgresql_server" "example" {
  name                = "postgresqlserver1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_virtual_network_rule" "example" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = azurerm_resource_group.example.name
  server_name                          = azurerm_postgresql_server.example.name
  subnet_id                            = azurerm_subnet.test2.id
  ignore_missing_vnet_service_endpoint = true
}