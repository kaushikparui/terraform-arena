####################################################
# Get latest Amazon Linux 2 AMI
####################################################
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

####################################################
# Create the Linux EC2 instance with a website
####################################################
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.barion_host_type
  key_name               = aws_key_pair.tf_key.key_name
  subnet_id              = aws_subnet.public_subnets[1].id
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]

  tags = {
    Name = "VPC-bastion-host"
  }
}