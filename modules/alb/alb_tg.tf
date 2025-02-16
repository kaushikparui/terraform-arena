####################################################
# Target Group
####################################################

resource "aws_lb_target_group" "app" {
  name_prefix = "alb-"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/"
    port                = 80
    matcher             = 200
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}