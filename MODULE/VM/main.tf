resource "azurerm_network_interface" "NIC" {
  name                = var.nic_name
  location            =  var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_linux_virtual_machine" "VM" {
  name                = var.vm_name
  location            =  var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
   disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
    ]
    


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}

