# Generate a secure random password inside Terraform
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  db_port = var.engine == "postgres" ? 5432 : 3306
  
  # Default usernames based on engine type
  default_username = var.engine == "postgres" ? "postgres" : "admin"
  
  # Default database name format
  default_db_name = var.engine == "postgres" ? "postgres" : "main_db"
}

resource "aws_db_instance" "this" {
  identifier             = "${var.prefix}-db"
  engine                 = var.engine
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_type           = "gp3"
  port                   = local.db_port
  db_name                = var.db_name != "" ? var.db_name : local.default_db_name
  
  # Enforce dynamic defaults if inputs are left blank
  username               = var.username != "" ? var.username : local.default_username
  password               = random_password.db_password.result
  
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = true  # RDS is public
  multi_az               = false # Single AZ
}