#############################################
# Define Azure Virtual Machine
#############################################
resource "azurerm_virtual_machine" "sonic" {
  name                             = var.vm_identifier
  location                         = azurerm_resource_group.sonic.location
  resource_group_name              = azurerm_resource_group.sonic.name
  network_interface_ids            = [azurerm_network_interface.sonic.id]
  vm_size                          = var.vm_type
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }

  storage_os_disk {
    name              = var.vm_disk
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.vm_disk_size
  }

  os_profile {
    computer_name  = var.vm_hostname
    admin_username = var.vm_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = tls_private_key.azure-pem-key.public_key_openssh
    }
  }
}