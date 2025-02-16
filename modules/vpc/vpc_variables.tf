variable "aws_region" {
  description = "Region of the Architecture deployment"
  type        = string
  default     = "us-west-1" ## N.California
}

variable "vpc_cidr" {
  description = "VPC CIDR value for the Custom VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "security_group_endpoints" {
  description = "Fetch VPC ENdpoint SG from SG Module using Parent main.tf"
  type = string
}