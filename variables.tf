variable "aws_region" {
  description = "Region of the Architecture deployment"
  type        = string
  default     = "us-west-1" ## N.California
}

variable "env" {
  description = "Describe the Environment of the application"
  type        = string
  default     = "dev" # Default environment, can be overridden via tfvars
}

variable "app_name" {
  description = "Denote application name"
  type        = string
  default     = "hrxz" ## This is Your Application Name, All resources will get this name
}