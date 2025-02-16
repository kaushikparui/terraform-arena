variable "aws_region" {
  description = "Region of the Architecture deployment"
  type        = string
  default     = "us-west-1" ## N.California
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
  default     = "725873549359.dkr.ecr.us-west-1.amazonaws.com/devin:latest"
}

variable "ecs_cluster_name" {
  description = "Define the ECS CLuster name here"
  type        = string
  default     = "ecs-app-cluster"
}

variable "ecs_task" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ecs_node_sg" {
  type = string
}

variable "ecsInstanceRoleProfile" {
  type = string
}

variable "ecsInstanceRole" {
  type = string
}

variable "log_grp_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "alb_target_grp" {
  type = string
}