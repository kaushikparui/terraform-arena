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

variable "pemfile" {
  description = "PEM file for the bastion host server"
  type        = string
  default     = "ecs_app_bastion"
}

variable "acm_arn" {
  description = "This is the ARN of ACM which needs to be taken befor the code-deployed via terraform"
  type        = string
  sensitive   = true
  default     = "arn:aws:acm:us-west-1:337909771265:certificate/a3112adc-1b17-4d10-9a48-4f56195f4bdf"
}

variable "barion_host_type" {
  description = "Instance type for the Bastion Host server"
  type        = string
  default     = "t3.micro"
}

variable "ecs_ec2_type" {
  description = "Instance type for the ECS cluster EC2 server"
  type        = string
  default     = "t3.micro"
}

variable "ecr_image_url" {
  description = "This is the Image URL from ECR"
  type        = string
  sensitive   = true
  default     = "337909771265.dkr.ecr.us-west-1.amazonaws.com/devin:latest"
}

variable "ecs_cluster_name" {
  description = "Define the ECS CLuster name here"
  type        = string
  default     = "ecs-app-cluster"
}