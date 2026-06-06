output "fe_public_ip" {
  value = length(aws_instance.frontend) > 0 ? aws_instance.frontend[0].public_ip : "Not Deployed"
}

output "be_public_ip" {
  value = length(aws_instance.backend) > 0 ? aws_instance.backend[0].public_ip : "Not Deployed"
}