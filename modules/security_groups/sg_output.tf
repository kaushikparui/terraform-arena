output "http" {
  description = "Expose http SG ID for other modules using parent main.tf"
  value = aws_security_group.http.id
}

output "ecs_node_sg" {
  description = "Expose ECS EC2 SG ID for other modules using parent main.tfvalue"
  value = aws_security_group.ecs_node_sg.id
}

output "ecs_task" {
  description = "Expose ECS Task SG ID for other modules using parent main.tf"
  value = aws_security_group.ecs_task.id
}

output "bastion_security_group" {
  description = "Expose Bastion Host SG ID for other modules using parent main.tf"
  value = aws_security_group.bastion_security_group.id
}

output "security_group_endpoints" {
  description = "Expose VPC Endpoint SG ID for other modules using parent main.tf"
  value = aws_security_group.security_group_endpoints.id
}