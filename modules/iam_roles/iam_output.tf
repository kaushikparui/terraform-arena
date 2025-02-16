output "ecsInstanceRoleProfile" {
  description = "Expose ECS Instance Profile for ECS Cluster using Parent main.tf "
  value = aws_iam_instance_profile.ecsInstanceRoleProfile.arn
}

output "ecsInstanceRole" {
  description = "Expose ECS Instance Role for ECS Cluster using Parent main.tf"
  value = aws_iam_role.ecsInstanceRole.arn
}