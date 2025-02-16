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
  key_name               = var.pemfile
  subnet_id              = element(var.public_subnets,0)
  vpc_security_group_ids = [var.bastion_security_group]

  tags = {
    Name = "VPC-bastion-host"
  }
}