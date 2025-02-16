variable "vpc_id" {
  description = "Fetch VPC ID from VPC module using parent main.tf"
  type = string
}

variable "acm_arn" {
  description = "This is the ARN of ACM which needs to be taken befor the code-deployed via terraform"
  type        = string
  sensitive   = true
  default     = "arn:aws:acm:us-west-1:725873549359:certificate/a7c00d3f-7bc6-407a-872d-0a72bae6e09f"
}

variable "public_subnets" {
  description = "Fetch Public Subnet List from VPC module using parent main.tf"
  type = list(string)
}
variable "security_groups_http" {
  description = "Fetch ALB Security Group from SG module using parent main.tf"
  type = string
}