output "bastion_host_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.bastion.bastion_host_ip
}

output "pemfile" {
  description = "PEM file"
  value       = module.pemfile.pemfile
}

output "alb_url" {
  description = "PEM file"
  value       = module.alb.alb_url
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds-mysql.rds_endpoint
}

output "rds_db_name" {
  description = "RDS DB Name"
  value       = module.rds-mysql.rds_db_name
}

output "rds_username" {
  description = "RDS Username"
  value       = module.rds-mysql.rds_username
}

output "rds_password" {
  description = "RDS Password"
  value       = module.rds-mysql.rds_password
  sensitive   = true
}