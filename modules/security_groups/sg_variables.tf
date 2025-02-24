variable "vpc_id" {
  description = "Fetch VPC ID from VPC Module using parent main.tf"
  type = string
}

variable "vpc_cidr" {
  description = "Fetch VPC CIDR Value from VPC Module using parent main.tf"
  type = string
}

variable "app_name" {
  description = "Application name"  ## Taking value from parent variables.tf
  type        = string
}

variable "env" {
  description = "Environment name"  ## Taking value from tfvars
  type        = string
}
