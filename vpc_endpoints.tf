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
/*
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


####################################################
# Associate Private Route Table with VPC Endpoints
####################################################
/*
resource "aws_vpc_endpoint_subnet_association" "private_subnet_association_endpoint" {
  count          = length(aws_subnet.private_subnets[*].id)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each       = { for idx, subnet_id in aws_subnet.private_subnets : idx => subnet_id }
  subnet_id      = each.value.id
  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint[count.index].id
} */

locals {
  endpoint_list = ["com.amazonaws.us-west-1.ecs-agent",
    "com.amazonaws.us-west-1.ecs-telemetry",
    "com.amazonaws.us-west-1.ecs",
    "com.amazonaws.us-west-1.ecr.dkr",
    "com.amazonaws.us-west-1.ecr.api",
    "com.amazonaws.us-west-1.logs",
    #    "com.amazonaws.us-west-1.ec2",
    #"com.amazonaws.us-west-1.s3",
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
  security_group_ids  = [aws_security_group.security_group_endpoints.id]

  tags = {
    Name = "vpc-Endpoint-${each.key}"
  }
}

####################################################
# Create the S3 Gateway Endpoints
####################################################
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-1.s3"
  vpc_endpoint_type = "Gateway"
  #subnet_ids   = aws_subnet.private_subnets[*].id
  #private_dns_enabled = true
  #security_group_ids  = [aws_security_group.security_group_endpoints.id]

  route_table_ids = [
    aws_route_table.private_route_table.id
  ]


  tags = {
    Name = "vpc-Endpoint-com.amazonaws.us-west-1.s3"
  }
}



####################################################
# Associate Private Route Table with VPC Endpoints
####################################################
/*resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each = { for idx, subnet in aws_subnet.private_subnets : idx => subnet.id }

  subnet_id       = each.value
  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint[local.endpoint_list[each.key]].id
}*/
