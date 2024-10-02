# --- ECS Node SG ---

resource "aws_security_group" "ecs_node_sg" {
  name_prefix = "demo-ecs-node-sg-"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.http.id]
  }

  ingress {
    description     = "Allow ingress traffic from ECS Task SG on ports"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ecs_task.id]
  }

  ingress {
    description     = "Allow SSH ingress traffic from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "ecs-ec2-sg" }
}

# --- ECS TASK SG ---

resource "aws_security_group" "ecs_task" {
  name_prefix = "ecs-sg-"
  description = "Allow all traffic within the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- ALB SG ---
####################################################
# --- ALB SG ---
####################################################
resource "aws_security_group" "http" {
  name_prefix = "load-balancer-sg-"
  description = "Allow all HTTP/HTTPS traffic from public"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

####################################################
# Create the security group for Bastion Host EC2
####################################################
resource "aws_security_group" "bastion_security_group" {
  description = "Allow traffic for EC2 Bastion Host"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [22, 80, 443]
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  /*dynamic "ingress" {
    #for_each = var.sg_ingress_ports
    for_each = [22, 443, 80]
    iterator = sg_ingress

    content {
      description = sg_ingress.value["description"]
      from_port   = sg_ingress.value["port"]
      to_port     = sg_ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }*/

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

####################################################
# Create the security group for VPC Endpoints
####################################################
resource "aws_security_group" "security_group_endpoints" {
  description = "Allow traffic for VPC Endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow ingress traffic from VPC internal"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
    #security_groups = [aws_security_group.ecs_node_sg.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "vpc_endpoint_sg" }
}