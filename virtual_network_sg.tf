#############################################
# Define Azure Network Security Group to allow port 22 for SSH 80 & 443 for Websites
#############################################
resource "azurerm_network_security_group" "sonic" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.sonic.location
  resource_group_name = azurerm_resource_group.sonic.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}