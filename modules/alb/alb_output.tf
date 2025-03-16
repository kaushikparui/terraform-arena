####################################################
# Application Load Balancer Outputs
####################################################
output "alb_target_grp_1" {
  value = aws_lb_target_group.app.arn
}
output "alb_target_grp_2" {
  value = aws_lb_target_group.app_2.arn
}
output "alb_url" {
  value = aws_lb.main.dns_name
}