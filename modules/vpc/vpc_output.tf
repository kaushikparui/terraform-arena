output "vpc_id" {
  description = "Expose VPC ID for other modules using Parent main.tf"
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Expose VPC CIDR for other modules using Parent main.tf"
  value = aws_vpc.main.cidr_block
}

output "private_subnets" {
  description = "Expose List of Private Subnets for other modules using Parent main.tf"
  value = aws_subnet.private_subnets[*].id
}

output "public_subnets" {
  description = "Expose List of Public Subnets for other modules using Parent main.tf"
  value = aws_subnet.public_subnets[*].id
}
