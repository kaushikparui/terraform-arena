output "log_name" {
  description = "Expose Cloudwatch Log Group Name For Other Modules"
  value = aws_cloudwatch_log_group.log.name
}