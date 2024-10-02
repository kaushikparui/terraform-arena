####################################################
# Get list of available AZs
####################################################
data "aws_availability_zones" "available_zones" {
  state = "available"
}

locals {
  azs_count = 2
  azs_names = data.aws_availability_zones.available_zones.names
}


####################################################
# Create the VPC
####################################################
resource "aws_vpc" "main" {
  #cidr_block           = "10.10.0.0/16"
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "ecs-vpc" }
}

####################################################
# Create the internet gateway
####################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "ecs-vpc-igw" }
}

####################################################
# Create the public subnets
####################################################
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.main.id

  count                   = 2
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true # This makes public subnet

  tags = { Name = "app-vpc-public-${local.azs_names[count.index]}" }
}

####################################################
# Create the private subnets
####################################################
resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.main.id

  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 2 + count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]

  map_public_ip_on_launch = false # This makes private subnet

  tags = { Name = "app-vpc-private-${local.azs_names[count.index]}" }
}

####################################################
# Create the public route table
####################################################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "ecs-vpc-public-rt" }

}

####################################################
# Create the private route table
####################################################
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "ecs-vpc-private-rt" }
}

####################################################
# Assign the public route table to the public subnet
####################################################
resource "aws_route_table_association" "public_rt_asso" {
  count          = 2
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

######################################################
# Assign the private route table to the private subnet
######################################################
resource "aws_route_table_association" "private_rt_asso" {
  count          = 2
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}