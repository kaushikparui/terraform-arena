# Define Azure Resource Group
resource "azurerm_resource_group" "sonic" {
  name     = var.resource_group_name
  location = var.resource_group_location
}