variable "barion_host_type" {
  description = "Instance type for the Bastion Host server"
  type        = string
  default     = "t3.micro"
}

variable "bastion_security_group" {
  description = "Fetch Bastion Host SG from SG module using parent main.tf"
  type = string
}

variable "pemfile" {
  description = "Fetch Pemfile Name from Pemfile module using parent main.tf"
  type = string
}

variable "public_subnets" {
  description = "Fetch List of Public Subnets from VPC module using parent main.tf"
  type = list(string)
}

variable "app_name" {
  description = "Application name"  ## Taking value from parent variables.tf
  type        = string
}

variable "env" {
  description = "Environment name"  ## Taking value from tfvars
  type        = string
}