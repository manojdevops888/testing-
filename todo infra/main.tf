# testing kar raha hu
# git kya isko check karta hai






module "resource_group" {
  source = "../MODULE/RESOURCE_GROUP"
  rg_details_name = "ziddi-rg"
  rg_details_location = "westus"
}
module "resource_group" {
  source = "../MODULE/RESOURCE_GROUP"
  rg_details_name = "ziddi-rg1"
  rg_details_location = "westus"
}

module "virtual_network_name" {

depends_on = [ module.resource_group ]
    source = "../MODULE/VNETS"
    VNET1_name = "ziddi-vnet"  
    VNET1_location = "westus"
    resource_group_name = "ziddi-rg"
    address_space = ["10.1.0.0/16"]
    
}

module "frontend_subnet"  {
    depends_on= [ module.virtual_network_name ]
    source= "../MODULE/SUBNET"
  Subnet_name = "frontend"
  resource_group_name = "ziddi-rg"
  virtual_network_name = "ziddi-vnet"
    address_prefixes     = ["10.1.0.0/24"]
}

module "backend_subnet" {
    depends_on = [ module.virtual_network_name ]
    source = "../MODULE/SUBNET"
  Subnet_name   = "backend"
  resource_group_name = "ziddi-rg"
  virtual_network_name = "ziddi-vnet"
    address_prefixes     = ["10.1.1.0/24"]
}

module "azurerm_public_ip" {
  source = "../MODULE/PIP"
  pip_name = "frontend-pip-ziddi"
  resource_group_name = "ziddi-rg"
  location = "westus"
  allocation_method = "Static"
}
  module "azurerm_public_backend_ip" {
  source = "../MODULE/PIP"
  pip_name = "backend-pip-ziddi"
  resource_group_name = "ziddi-rg"
  location = "westus"
  allocation_method = "Static"
}
module "azurerm_linux_virtual_machine" {
  source = "../MODULE/VM"
  vm_name = "ziddi-fromtendvm"
  resource_group_name = "ziddi-rg"
  location = "westus"
  vm_size = "Standard_B1s"
  admin_username = "ziddiadmin"
  admin_password = "Ziddi1234"
  nic_name = "frontend-pip-ziddi"
  subnet_id = data.azurerm_subnet.frontend_subnet.id
  image_publisher = "Canonical"
  sku = "18.04-LTS"
  offer = "ubuntuserver"
  public_ip_id = "/subscriptions/ba578ce6-e042-4ed5-9e0b-99d4cc681a62/resourceGroups/ziddi-rg/providers/Microsoft.Network/publicIPAddresses/frontend-pip-ziddi"
  depends_on = [ module.frontend_subnet, module.backend_subnet, module.azurerm_public_ip ]
}
module "azurerm_linux_virtual_machine_b" {
  source = "../MODULE/VM"
  vm_name = "ziddi-backendvm"
  resource_group_name = "ziddi-rg"
  location = "westus"
  vm_size = "Standard_B1s"
  admin_username = "ziddiadmin"
  admin_password = data.azurerm_key_vault_secret.secret.value
  nic_name = "backend-pip-ziddi"
  subnet_id = data.azurerm_subnet.backend_subnet.id
  image_publisher = "Canonical"
  sku = "20_04-lts"
  offer = "0001-com-ubuntu-server-focal"
  public_ip_id = "/subscriptions/ba578ce6-e042-4ed5-9e0b-99d4cc681a62/resourceGroups/ziddi-rg/providers/Microsoft.Network/publicIPAddresses/backend-pip-ziddi"
  depends_on = [ module.backend_subnet, module.backend_subnet, module.azurerm_public_ip ]
}
module "azurerm_mssql_server" {
  source = "../MODULE/mssql_server"
  sql_server_name = "ziddi-sqlserver"
  resource_group_name = "ziddi-rg"
  location = "westus"
  sql_server_admin_login = "ziddiadmin"
  sql_server_admin_password = data.azurerm_key_vault_secret.secret.value
}

data "azurerm_subnet" "backend_subnet" {
  name                 = "backend"
  virtual_network_name = "ziddi-vnet"
  resource_group_name  = "ziddi-rg"
}

data "azurerm_subnet" "frontend_subnet" {
  name                 = "frontend"
  virtual_network_name = "ziddi-vnet"
  resource_group_name  = "ziddi-rg"
}

data "azurerm_key_vault" "keyvault" {
  name                = "Ziddi-kb"
  resource_group_name = "ziddi-rg"
}
data "azurerm_key_vault_secret" "secret" {
  name         = "ziddiadmin"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


# module "azurerm_mssql_database" {
#   source = "../MODULE/database"
#   sql_database_name = "ziddi-database"
#   sql_server_id = module.azurerm_sql_server.azurerm_sql_server.id
#   collation = "SQL_Latin1_General_CP1_CI_AS"
# }