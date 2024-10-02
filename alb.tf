####################################################
# Application Load Balancer
####################################################

resource "aws_lb" "main" {
  name               = "ecs-alb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public_subnets[*].id
  security_groups    = [aws_security_group.http.id]
}

resource "aws_lb_target_group" "app" {
  name_prefix = "alb-"
  vpc_id      = aws_vpc.main.id
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

output "alb_url" {
  value = aws_lb.main.dns_name
}
