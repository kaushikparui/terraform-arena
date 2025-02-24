variable "aws_region" {
  description = "Fetch AWS Region from parent variables.tf"
  type = string
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

variable "ecs_task" {
  description = "Fetch ECS Task SG from SG Module using Parent main.tf"
  type = string
}

variable "private_subnets" {
  description = "Fetch List of Private Subnets from VPC Module using Parent main.tf"
  type = list(string)
}

variable "ecs_node_sg" {
  description = "Fetch ECS EC2 Node SG from SG Module using Parent main.tf"
  type = string
}

variable "ecsInstanceRoleProfile" {
  description = "Fetch ECS Instance Profile from IAM Role Module using Parent main.tf"
  type = string
}

variable "ecsInstanceRole" {
  description = "Fetch ECS Instance Role from IAM Role Module using Parent main.tf"
  type = string
}

variable "log_grp_name" {
  description = "Fetch ECS Clouswatch Log Group from Cloudwatch Module using Parent main.tf"
  type = string
}

variable "key_name" {
  description = "Fetch ECS EC2 Instance Pemfile from Pemfile Module using Parent main.tf"
  type = string
}

variable "alb_target_grp" {
  description = "Fetch ALB Target Group from ALB Module using Parent main.tf"
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