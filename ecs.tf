####################################################
# ECS Cluster
####################################################

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

####################################################
# ECS Lunch Template
####################################################

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name_prefix            = "ecs-ec2-node-"
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = var.ecs_ec2_type
  key_name               = aws_key_pair.tf_key.key_name
  vpc_security_group_ids = [aws_security_group.ecs_node_sg.id]
  update_default_version = true

  private_dns_name_options { enable_resource_name_dns_a_record = false }

  iam_instance_profile { arn = aws_iam_instance_profile.ecsInstanceRoleProfile.arn }
  monitoring { enabled = true }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp3"
    }
  }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config;
    EOF
  )
}

####################################################
# ECS Task Defination
####################################################

resource "aws_ecs_task_definition" "app" {
  family             = "ecs-td"
  task_role_arn      = aws_iam_role.ecsInstanceRole.arn
  execution_role_arn = aws_iam_role.ecsInstanceRole.arn
  network_mode       = "awsvpc"
  cpu                = 512
  memory             = 512

  container_definitions = jsonencode([{
    name         = "app",
    image        = "${var.ecr_image_url}",
    essential    = true,
    portMappings = [{ containerPort = 80, hostPort = 80 }],

    /*environment = [
      { name = "EXAMPLE", value = "example" }
    ]*/

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = "${var.aws_region}",
        "awslogs-group"         = aws_cloudwatch_log_group.log.name,
        "awslogs-stream-prefix" = "app"
      }
    },
  }])
}

####################################################
# ECS Service
####################################################

resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  network_configuration {
    security_groups = [aws_security_group.ecs_task.id]
    subnets         = (aws_subnet.private_subnets[*].id)
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    base              = 1
    weight            = 100
  }
  ## Spread tasks evenly accross all Availability Zones for High Availability
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ## Make use of all available space on the Container Instances
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_lb_target_group.app, aws_iam_role.ecsInstanceRole]

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 80
  }

}

####################################################
# ECS Capacity provider
####################################################

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