output "bastion_host_ip" {
    description = "Display Bastion Host Public IP"
    value = aws_instance.web.public_ip
}