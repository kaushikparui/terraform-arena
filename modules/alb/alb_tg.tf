####################################################
# Target Group
####################################################

resource "aws_lb_target_group" "app" {
  name_prefix = "alb-"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    name = "${var.app_name}-${var.env}-alb-ecs-tg"
  }
}