# --- ALB ---

resource "aws_lb" "main" {
  name               = "ecs-alb"
  load_balancer_type = "application"
  #subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  subnets         = aws_subnet.public_subnets[*].id
  security_groups = [aws_security_group.http.id]
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
    type = "forward"
    #type             = "redirect"
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
  #certificate_arn   = "arn:aws:acm:us-west-1:725873549359:certificate/53f0eccc-15fe-469c-809b-e64bf96c5c57"
  certificate_arn = "arn:aws:acm:us-west-1:337909771265:certificate/a3112adc-1b17-4d10-9a48-4f56195f4bdf"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = {
    Name = "https-listener"
  }
}

/*resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      host        = "ecs.radiantglacier.site"
      status_code = "HTTP_301"
    }
  }

  condition {
    http_header {
      http_header_name = "X-Forwarded-For"
      values           = [aws_lb.main.dns_name]
    }
  }

  tags = {
    Name = "http-to-https-redirection"
  }
}*/


output "alb_url" {
  value = aws_lb.main.dns_name
}
