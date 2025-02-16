variable "barion_host_type" {
  description = "Instance type for the Bastion Host server"
  type        = string
  default     = "t3.micro"
}

variable "bastion_security_group" {
  type = string
}

variable "pemfile" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}