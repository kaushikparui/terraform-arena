output "ecs_cluster_name" {
  description = "Expose ECS Cluster Name for Other Modules"
  value = aws_ecs_cluster.main.name
}