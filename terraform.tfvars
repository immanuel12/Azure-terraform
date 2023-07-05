location         = "southeastasia"
environment      = "dev"
project_name     = "Nuektest"

###################################################################################################
### Azure Sql
###################################################################################################

azure_sql = {
  "sql_db_name"               = "SampleDB"
  "admin_username"            = "azureadmin"
  "admin_password"            = null
  "version"                   = "12.0"
}

###################################################################################################
### Virtual Machine
###################################################################################################

azure_vm = {
  "prefix"                    = "tfvmex"
  "resource_group_location"   = "southeastasia"
  "azurerm_subnet_name"       = "internal"
  "size"                      = "Standard_DS1_v2"
}

storage_image = {
  "publish"                   = "Canonical"
  "offer"                     = "UbuntuServer"
  "sku"                       = "18.04-LTS"
  "version"                   = "latest"
}

storage_disk = {
  "name"                      = "myosdisk1"
  "caching"                   = "ReadWrite"
  "option"                    = "FromImage"
  "disk_type"                 = "Standard_LRS"
}

os_profile = {
  "name"                      = "hostname"
  "username"                  = "testadmin"
  "password"                  = "Password1234!"
}

###################################################################################################
### Storage Account
###################################################################################################

stoacc = {
  "virnet"                    = "virtnettest"
  "subnet_name"               = "subnettest"
  "storage_name"              = "storetest"
  "tier"                      = "Standard"
  "replication_type"          = "LRS" 
}