output "alb_target_grp" {
  value = aws_lb_target_group.app.arn
}
output "alb_url" {
  value = aws_lb.main.dns_name
}