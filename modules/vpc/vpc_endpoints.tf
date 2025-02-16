####################################################
# VPC Endpoints' list of services
####################################################
locals {
  endpoint_list = [
    "com.amazonaws.${var.aws_region}.ecs-agent",
    "com.amazonaws.${var.aws_region}.ecs-telemetry",
    "com.amazonaws.${var.aws_region}.ecs",
    "com.amazonaws.${var.aws_region}.ecr.dkr",
    "com.amazonaws.${var.aws_region}.ecr.api",
    "com.amazonaws.${var.aws_region}.logs",
  ]
}

####################################################
# Create the VPC endpoints
####################################################
resource "aws_vpc_endpoint" "vpc_endpoint" {
  for_each          = { for idx, name in local.endpoint_list : name => idx }
  vpc_id            = aws_vpc.main.id
  vpc_endpoint_type = "Interface"
  service_name      = each.key
  subnet_ids        = aws_subnet.private_subnets[*].id
  #subnet_ids          = [aws_subnet.ecs-subnet-private-1.id, aws_subnet.ecs-subnet-private-2.id]
  private_dns_enabled = true
  security_group_ids  = [var.security_group_endpoints]

  tags = {
    Name = "vpc-Endpoint-${each.key}"
  }
}

####################################################
# Create the S3 Gateway Endpoints
####################################################
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3" # Dynamically set region
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_route_table.id
  ]

  tags = {
    Name = "vpc-Endpoint-com.amazonaws.${var.aws_region}.s3"
  }
}
