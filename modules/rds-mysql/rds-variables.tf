variable "rds_mysql_sg" {
  description = "Fetching RDS SG name using parent main.tf"
  type = string
}

variable "vpc_id" {
  description = "Fetch VPC ID from VPC Module using parent main.tf"
  type = string
}

variable "private_subnets" {
  description = "Fetch List of Private Subnets from VPC Module using Parent main.tf"
  type = list(string)
}

variable "env" {
  description = "Environment name"  ## Taking value from tfvars
  type        = string
}

variable "app_name" {
  description = "Application name"  ## Taking value from parent variables.tf
  type        = string
}
variable "rds_instance_class" {
  description = "Database RDS instance class"
  type = string
  #default = "db.t3.micro"
}