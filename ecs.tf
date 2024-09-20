# --- ECS Cluster ---

resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

# --- ECS Launch Template ---

data "aws_ssm_parameter" "ecs_node_ami" {
  #name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name_prefix   = "ecs-ec2-node-"
  image_id      = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type = "t3.micro"
  #vpc_security_group_ids = [aws_security_group.ecs_task.id]
  vpc_security_group_ids = [aws_security_group.ecs_node_sg.id]
  iam_instance_profile { arn = aws_iam_instance_profile.ecs_node.arn }
  monitoring { enabled = true }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config;
    EOF
  )
}

# --- ECS Task Definition ---

resource "aws_ecs_task_definition" "app" {
  family             = "ecs-td"
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 256

  container_definitions = jsonencode([{
    name = "app",
    #    image        = "${aws_ecr_repository.app.repository_url}:latest",
    #image        = "725873549359.dkr.ecr.us-west-1.amazonaws.com/devin:latest",
    image        = "337909771265.dkr.ecr.us-west-1.amazonaws.com/devin:latest",
    essential    = true,
    portMappings = [{ containerPort = 80, hostPort = 80 }],

    /*environment = [
      { name = "EXAMPLE", value = "example" }
    ]

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = "us-east-1",
        "awslogs-group"         = aws_cloudwatch_log_group.ecs.name,
        "awslogs-stream-prefix" = "app"
      }
    },*/
  }])
}

# --- ECS Service ---

resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  network_configuration {
    security_groups = [aws_security_group.ecs_task.id]
    #subnets         = [aws_subnet.public_1.id]
    subnets         = aws_subnet.public_subnets[*].id
    #subnets         = [aws_subnet.private.id]
    #subnets         = aws_subnet.public[*].id
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    base              = 1
    weight            = 100
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_lb_target_group.app]

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 80
  }

}

# --- ECS Capacity Provider ---

resource "aws_ecs_capacity_provider" "main" {
  name = "ec2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.main.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    base              = 1
    weight            = 100
  }
}