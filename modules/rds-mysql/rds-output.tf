output "rds_endpoint" {
  description = "RDS endpoint accessible through the bastion host tunnel or private subnets"
  value       = aws_db_instance.mysql_instance.endpoint
}

output "rds_db_name" {
  description = "RDS Database Name"
  value = aws_db_instance.mysql_instance.db_name
}

output "rds_username" {
  description = "RDS username"
  value = aws_db_instance.mysql_instance.username
}

output "rds_password" {
  description = "RDS password"
  value = aws_db_instance.mysql_instance.password
}