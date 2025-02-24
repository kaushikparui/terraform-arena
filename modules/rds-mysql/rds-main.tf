####################################################
# Getting Private Subnet Group Details from VPC
####################################################
data "aws_vpc" "main" {
  id = var.vpc_id
}

locals {
  private_subnet_map = { for idx, subnet_id in var.private_subnets : "subnet_${idx + 1}" => subnet_id }
}

data "aws_subnet" "private" {
  for_each = local.private_subnet_map
  id       = each.value
}

####################################################
# Generate Random Password for RDS
####################################################
resource "random_password" "rds_password" {
  length  = 16
  special = true
}

####################################################
# MySQL RDS Instance
####################################################
resource "aws_db_instance" "mysql_instance" {
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  identifier             = "${var.app_name}_${var.env}_database"
  db_name                = "${var.app_name}_${var.env}_db"
  username               = "${var.app_name}_${var.env}_usr"
  password               = random_password.rds_password.result
  parameter_group_name = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.rds_mysql_sg]
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  publicly_accessible    = false  # RDS is private
  multi_az               = false  # Single AZ

  tags = { Name = "${var.app_name}-${var.env}-ecs-ec2-node-sg" }
}

####################################################
# MySQL RDS Instance Subnet Group
####################################################
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name        = "${var.app_name}-${var.env}-mysql-private-subnet-group"
  subnet_ids  = [for subnet in data.aws_subnet.private : subnet.id]
  description = "Subnet group for RDS in private subnets"
}