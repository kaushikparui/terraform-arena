####################################################
# Application Load Balancer (HTTP)
####################################################

resource "aws_lb" "main" {
  name               = "${var.app_name}-${var.env}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets[*]
  security_groups    = var.security_groups_http[*]
}

####################################################
# ALB Listener Rule (HTTP)
####################################################

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "http-listeners"
  }
}

resource "aws_lb_listener_rule" "http_app_2" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type             = "redirect"

      redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/app2*"]
    }
  }
  tags = {
    Name = "application 2"
  }
}

####################################################
# ALB Listener Rule (HTTPS)
####################################################

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

resource "aws_lb_listener_rule" "https_app_2" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_2.arn
  }

  condition {
    path_pattern {
      values = ["/app2*"]
    }
  }

  tags = {
    Name = "application 2"
  }
}