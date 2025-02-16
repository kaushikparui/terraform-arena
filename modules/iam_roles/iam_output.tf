output "ecsInstanceRoleProfile" {
  value = aws_iam_instance_profile.ecsInstanceRoleProfile.arn
}

output "ecsInstanceRole" {
  value = aws_iam_role.ecsInstanceRole.arn
}