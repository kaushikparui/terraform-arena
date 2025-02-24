variable "app_name" {
  description = "Application name"  ## Taking value from parent variables.tf
  type        = string
}

variable "env" {
  description = "Environment name"  ## Taking value from tfvars
  type        = string
}