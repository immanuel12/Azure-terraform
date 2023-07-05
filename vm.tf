resource "azurerm_virtual_network" "main" {
  name                = "${var.azure_vm["prefix"]}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = var.azure_vm["azurerm_subnet_name"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.azure_vm["prefix"]}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.azure_vm["prefix"]}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.azure_vm["size"]

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.storage_image["publish"]
    offer     = var.storage_image["offer"]
    sku       = var.storage_image["sku"]
    version   = var.storage_image["version"]
  }
  storage_os_disk {
    name              = var.storage_disk["name"]
    caching           = var.storage_disk["caching"]
    create_option     = var.storage_disk["option"]
    managed_disk_type = var.storage_disk["disk_type"]
  }
  os_profile {
    computer_name  = var.os_profile["name"]
    admin_username = var.os_profile["username"]
    admin_password = var.os_profile["password"]
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}