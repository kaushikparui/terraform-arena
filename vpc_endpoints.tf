####################################################
# Create VPC Endpoints for following Services
# com.amazonaws.us-west-1.ecs-agent     - VPC Interface Endpoint  
# com.amazonaws.us-west-1.ecs-telemetry - VPC Interface Endpoint
# com.amazonaws.us-west-1.ecs           - VPC Interface Endpoint
# com.amazonaws.us-west-1.ecr.dkr       - VPC Interface Endpoint
# com.amazonaws.us-west-1.ecr.api       - VPC Interface Endpoint
# com.amazonaws.us-west-1.logs          - VPC Interface Endpoint
# com.amazonaws.us-west-1.s3            - VPC Gateway Endpoint
####################################################
locals {
  endpoint_list = ["com.amazonaws.us-west-1.ecs-agent",
    "com.amazonaws.us-west-1.ecs-telemetry",
    "com.amazonaws.us-west-1.ecs",
    "com.amazonaws.us-west-1.ecr.dkr",
    "com.amazonaws.us-west-1.ecr.api",
    "com.amazonaws.us-west-1.logs",
  ]
}

####################################################
# Create the VPC endpoints
####################################################
resource "aws_vpc_endpoint" "vpc_endpoint" {
  count               = 6
  vpc_id              = aws_vpc.main.id
  vpc_endpoint_type   = "Interface"
  service_name        = local.endpoint_list[count.index]
  subnet_ids          = aws_subnet.private_subnets[*].id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.security_group_endpoints.id]

  tags = {
    Name = "vpc-Endpoint-${local.endpoint_list[count.index]}"
  }
}

####################################################
# Create VPC Gateway Endpoint for S3
####################################################
/*resource "aws_vpc_endpoint" "vpc_endpoint_s3" {
  vpc_id            = aws_vpc.main.id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.us-west-1.s3"
  route_table_ids   = [var.private_route_table_id]

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-Endpoint-com.amazonaws.us-west-1.s3"
  })
}*/