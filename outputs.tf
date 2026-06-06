output "frontend_ip" {
  value = module.compute.fe_public_ip
}

output "backend_ip" {
  value = module.compute.be_public_ip
}

####################################################
# AUTO-GENERATED DATABASE CREDENTIALS OUTPUT
####################################################
output "database_connection_info" {
  description = "Connection map and dynamically auto-generated RDS root credentials"
  value = length(module.database) > 0 ? {
    engine             = var.db_engine
    endpoint           = module.database[0].endpoint
    database_name      = module.database[0].db_name
    assigned_username  = module.database[0].username
    generated_password = module.database[0].password 
  } : null
  sensitive = true
}

output "view_db_password_command" {
  description = "Run this command to view the generated credentials and password immediately:"
  value       = length(module.database) > 0 ? "terraform output database_connection_info" : "Database not deployed"
}