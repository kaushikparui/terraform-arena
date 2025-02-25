####################################################
# ECS Cluster
####################################################

resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.env}-cluster"
}

####################################################
# ECS Lunch Template
####################################################

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name_prefix            = "${var.app_name}-${var.env}-ecs-ec2-node-"
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = var.ecs_ec2_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.ecs_node_sg]
  update_default_version = true

  private_dns_name_options { enable_resource_name_dns_a_record = false }

  iam_instance_profile { arn = var.ecsInstanceRoleProfile }
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
  family             = "${var.app_name}-${var.env}-ecs-td"
  task_role_arn      = var.ecsInstanceRole
  execution_role_arn = var.ecsInstanceRole
  network_mode       = "bridge"
  cpu                = 512
  memory             = 512

  container_definitions = jsonencode([{
    name         = "${var.app_name}-${var.env}-app",
    image        = "${var.ecr_image_url}",
    essential    = true,
    portMappings = [{ containerPort = 80, hostPort = 0 }],

    /*environment = [
      { name = "EXAMPLE", value = "example" }
    ]*/

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = "${var.aws_region}",
        "awslogs-group"         = var.log_grp_name
        "awslogs-stream-prefix" = "${var.app_name}-${var.env}-app"
      }
    },
  }])
}

####################################################
# ECS Service
####################################################

resource "aws_ecs_service" "app" {
  name            = "${var.app_name}-${var.env}-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  ## The network_configuration block is only valid for awsvpc network mode. no need for bridge mode
  #network_configuration {
  #  security_groups = [var.ecs_task]
  #  subnets         = (var.private_subnets[*])
  #}

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

  depends_on = [var.alb_target_grp, var.ecsInstanceRole]

  load_balancer {
    target_group_arn = var.alb_target_grp
    container_name   = "${var.app_name}-${var.env}-app"
    container_port   = 80
  }

}

####################################################
# ECS Capacity provider
####################################################

resource "aws_ecs_capacity_provider" "main" {
  name = "${var.app_name}-${var.env}-ec2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = var.asg_max_node
      minimum_scaling_step_size = var.asg_min_node
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