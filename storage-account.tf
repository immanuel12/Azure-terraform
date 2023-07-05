resource "azurerm_virtual_network" "virnettest" {
  name                = var.stoacc["virnet"]
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnettest" {
  name                 = var.stoacc["subnet_name"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virnettest.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "storagetest" {
  name                = var.stoacc["storage_name"]
  resource_group_name = azurerm_resource_group.rg.name

  location                 = azurerm_resource_group.rg.location
  account_tier             = var.stoacc["tier"]
  account_replication_type = var.stoacc["replication_type"]

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.subnettest.id]
  }

  tags = {
    environment = "staging"
  }
}