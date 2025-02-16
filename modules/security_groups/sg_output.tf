output "http" {
  value = aws_security_group.http.id
}

output "ecs_node_sg" {
  value = aws_security_group.ecs_node_sg.id
}

output "ecs_task" {
  value = aws_security_group.ecs_task.id
}

output "bastion_security_group" {
  value = aws_security_group.bastion_security_group.id
}

output "security_group_endpoints" {
  value = aws_security_group.security_group_endpoints.id
}