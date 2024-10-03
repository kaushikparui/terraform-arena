#############################################
# Define Azure Virtual Network
#############################################
resource "azurerm_virtual_network" "sonic" {
  name                = var.virtual_network_name
  address_space       = [var.vpc_cidr]
  location            = azurerm_resource_group.sonic.location
  resource_group_name = azurerm_resource_group.sonic.name
}

#############################################
# Define Azure Subnet within the Virtual Network
#############################################
resource "azurerm_subnet" "sonic" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.sonic.name
  virtual_network_name = azurerm_virtual_network.sonic.name
  address_prefixes     = [var.subnet_cidr]
}
#############################################
# Associate with the Network Security Group
#############################################
resource "azurerm_subnet_network_security_group_association" "network_grp_asso" {
  subnet_id                 = azurerm_subnet.sonic.id
  network_security_group_id = azurerm_network_security_group.sonic.id
}
#############################################
# Creating Public IP Address for Azure Network Interface
#############################################
resource "azurerm_public_ip" "sonic" {
  name                = var.public_ip_address
  location            = azurerm_resource_group.sonic.location
  resource_group_name = azurerm_resource_group.sonic.name
  #allocation_method   = "Dynamic"
  allocation_method = "Static"
}
#############################################
# Define Network Interface connected to the Virtual Network
#############################################
resource "azurerm_network_interface" "sonic" {
  name                = var.network_interface
  location            = azurerm_resource_group.sonic.location
  resource_group_name = azurerm_resource_group.sonic.name

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.sonic.id
    name                          = var.network_interface_ip_config
    subnet_id                     = azurerm_subnet.sonic.id
    private_ip_address_allocation = "Dynamic"
  }
}