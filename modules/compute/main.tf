# Frontend Server
resource "aws_instance" "frontend" {
  count                  = var.deploy_frontend ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.fe_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags                   = { Name = "${var.prefix}-fe" }
}

resource "aws_ebs_volume" "fe_volume" {
  count             = var.deploy_frontend ? 1 : 0
  availability_zone = aws_instance.frontend[0].availability_zone
  size              = var.fe_ssd_size
  type              = "gp3"
  tags              = { Name = "${var.prefix}-fe-volume" }
}

resource "aws_volume_attachment" "fe_attach" {
  count       = var.deploy_frontend ? 1 : 0
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.fe_volume[0].id
  instance_id = aws_instance.frontend[0].id
}

# Backend Server
resource "aws_instance" "backend" {
  count                  = var.deploy_backend ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.be_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags                   = { Name = "${var.prefix}-be" }
}

resource "aws_ebs_volume" "be_volume" {
  count             = var.deploy_backend ? 1 : 0
  availability_zone = aws_instance.backend[0].availability_zone
  size              = var.be_ssd_size
  type              = "gp3"
  tags              = { Name = "${var.prefix}-be-volume" }
}

resource "aws_volume_attachment" "be_attach" {
  count       = var.deploy_backend ? 1 : 0
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.be_volume[0].id
  instance_id = aws_instance.backend[0].id
}