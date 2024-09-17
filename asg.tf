# --- ECS ASG ---

resource "aws_autoscaling_group" "ecs" {
  name_prefix         = "ecs-asg-"
  vpc_zone_identifier = [aws_subnet.public_1.id]
  #vpc_zone_identifier = [aws_subnet.private.id]
  #vpc_zone_identifier       = aws_subnet.public[*].id
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 10
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-cluster"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}