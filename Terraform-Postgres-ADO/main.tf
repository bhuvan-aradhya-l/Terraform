data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "bhuvan-postgres-flex"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "14"
  administrator_login    = "pgadmin"
  administrator_password = "@Aradhya12345!"

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  zone = "1"
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "appdb"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}