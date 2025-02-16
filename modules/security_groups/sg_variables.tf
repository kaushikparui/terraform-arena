variable "vpc_id" {
  description = "Fetch VPC ID from VPC Module using parent main.tf"
  type = string
}

variable "vpc_cidr" {
  description = "Fetch VPC CIDR Value from VPC Module using parent main.tf"
  type = string
}