variable "vpc_id" {
  type = string
}

variable "acm_arn" {
  description = "This is the ARN of ACM which needs to be taken befor the code-deployed via terraform"
  type        = string
  sensitive   = true
  default     = "arn:aws:acm:us-west-1:725873549359:certificate/a7c00d3f-7bc6-407a-872d-0a72bae6e09f"
}

variable "public_subnets" {
  description = "List of Public Subnets will be fetched here"
  type = list(string)
}
variable "security_groups_http" {
  type = string
}