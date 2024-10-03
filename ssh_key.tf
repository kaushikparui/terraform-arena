#############################################
# Create SSH Key
#############################################
resource "tls_private_key" "azure-pem-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
  content = tls_private_key.azure-pem-key.private_key_pem
  #filename = "${path.module}/id_rsa"
  file_permission = 400 # (Only applicable for local linux system)
  filename        = var.key_file_name
}