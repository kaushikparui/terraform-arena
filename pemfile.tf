####################################################
# Create PEM File and Download in the Local System
####################################################
resource "aws_key_pair" "tf_key" {
  key_name   = "ecs_app_bastion"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_key" {
  content         = tls_private_key.rsa.private_key_pem
  file_permission = 400 # (Only applicable for local linux system)
  filename        = "ecs_app_bastion.pem"
}