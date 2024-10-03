#############################################
# Terraform (IAC) Outputs
#############################################
output "vm_instance_username" {
  value = var.vm_username
}
output "vm_instance_public_ip" {
  value = azurerm_public_ip.sonic.ip_address
}
output "vm_instance_key_file" {
  value = local_file.private_key.filename
}
output "db_server_endpoint" {
  value = azurerm_mysql_flexible_server.sonic-db-server.fqdn
}
output "db_server_username" {
  value = azurerm_mysql_flexible_server.sonic-db-server.administrator_login
}
output "db_server_password" {
  value     = azurerm_mysql_flexible_server.sonic-db-server.administrator_password
  sensitive = true
}
output "db_server_port" {
  value = "3306"
}