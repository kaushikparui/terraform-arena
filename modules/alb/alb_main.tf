####################################################
# Application Load Balancer
####################################################

resource "aws_lb" "main" {
  name               = "${var.app_name}-${var.env}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets[*]
  security_groups    = var.security_groups_http[*]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.id
  }

  tags = {
    Name = "http-listener"
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = {
    Name = "https-listener"
  }
}
