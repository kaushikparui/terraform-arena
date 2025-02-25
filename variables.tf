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

variable "bastion_host_type" {
  description = "Provide Instance Type for Bastion Host server"
  type        = string ## Value fetching from prod/stag/dev.tfvars
}

variable "ecs_ec2_type" {
  description = "Provide Instance Type for ECS EC2 Instance"
  type        = string ## Value fetching from prod/stag/dev.tfvars
}

variable "rds_instance_class" {
  description = "Provide Instance Type for the RDS Instance"
  type        = string ## Value fetching from prod/stag/dev.tfvars
}
variable "asg_max_node" {
  description = "Provide Maximum instance for AGS"
  type        = string ## Value fetching from prod/stag/dev.tfvars
}
variable "asg_min_node" {
  description = "Provide Minimum instance for AGS"
  type        = string ## Value fetching from prod/stag/dev.tfvars
}