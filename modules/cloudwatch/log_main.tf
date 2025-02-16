####################################################
# Create cloudWatch Log Group
####################################################
resource "aws_cloudwatch_log_group" "log" {
  name              = var.ecs_cluster_name
  retention_in_days = 14
}