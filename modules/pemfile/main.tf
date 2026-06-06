resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key" {
  key_name   = "${var.prefix}-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "tf_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "${path.cwd}/${var.prefix}-key.pem"
  file_permission = "0400" # Safe string format for octal permissions
}