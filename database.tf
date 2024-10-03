#############################################
# Define Azure Flexible Server for Database
#############################################
resource "azurerm_mysql_flexible_server" "sonic-db-server" {
  name                   = var.db_servername
  location               = azurerm_resource_group.sonic.location
  resource_group_name    = azurerm_resource_group.sonic.name
  sku_name               = var.db_sku
  administrator_login    = var.db_server_username
  administrator_password = var.db_server_password
  version                = "8.0.21"

  storage {
    iops    = 360
    size_gb = var.db_server_size
  }

  tags = {
    environment = var.db_server_tag
  }
}

#############################################
# Create MySQL Database in Flexible Server
#############################################
resource "azurerm_mysql_flexible_database" "sonic-db" {
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
  name                = var.db_name
  resource_group_name = azurerm_resource_group.sonic.name
  server_name         = azurerm_mysql_flexible_server.sonic-db-server.name
}

#############################################
# DB Firewalls
#############################################
resource "azurerm_mysql_flexible_server_firewall_rule" "AllowAll" {
  name                = "AllowAll"
  resource_group_name = azurerm_mysql_flexible_server.sonic-db-server.resource_group_name
  server_name         = azurerm_mysql_flexible_server.sonic-db-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  depends_on          = [azurerm_mysql_flexible_server.sonic-db-server] ## DB Server must be created first else it will through an error in terraform deployment
}

resource "azurerm_mysql_flexible_server_configuration" "sonic_db_conf" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.sonic.name
  server_name         = azurerm_mysql_flexible_server.sonic-db-server.name
  value               = "OFF"
}