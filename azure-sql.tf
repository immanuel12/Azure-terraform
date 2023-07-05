resource "random_pet" "azurerm_mssql_server_name" {
  prefix = "sql"
}

resource "random_password" "admin_password" {
  count       = var.azure_sql["admin_password"] == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

locals {
  admin_password = try(random_password.admin_password[0].result, var.azure_sql["admin_password"])
}

resource "azurerm_mssql_server" "server" {
  name                         = random_pet.azurerm_mssql_server_name.id
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  administrator_login          = var.azure_sql["admin_username"]
  administrator_login_password = local.admin_password
  version                      = var.azure_sql["version"]
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "db" {
  name      = var.azure_sql["sql_db_name"]
  server_id = azurerm_mssql_server.server.id
}