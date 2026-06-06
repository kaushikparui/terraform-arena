# Application Variables
variable "aws_region" {
  type    = string
}

variable "aws_profile" {
  type    = string
}

variable "app_name" { 
    type = string 
}

variable "env" { 
    type = string 
}

variable "os_distribution" {
  type    = string
  default = "ubuntu-24.04"
}

# Compute Toggles & Specs
variable "deploy_frontend" {
  type    = bool
  default = true
}

variable "deploy_backend" { 
    type = bool
    default = true 
}

variable "fe_instance_type" {
    type = string 
}

variable "be_instance_type" { 
    type = string 
}
variable "fe_ssd_size" { 
    type = number 
}
variable "be_ssd_size" { 
    type = number 
}

# Database Toggle & Specs
variable "deploy_rds" { 
    type = bool
    default = true 
}
variable "db_engine" { 
    type = string 
}
variable "db_instance_class" { 
    type = string 
}
variable "db_allocated_storage" { 
    type = number 
}
variable "db_username" { 
    type = string 
}
variable "db_password" { 
    type = string
    sensitive = true 
}

# Storage Toggle
variable "deploy_s3" { 
    type = bool
    default = true 
}

variable "bucket_name" { 
    type = string 
}