
resource "azurerm_virtual_network" "VNET1" {
  name                = var.VNET1_name
  location            = var.VNET1_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}