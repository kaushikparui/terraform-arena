####################################################
# Compiling Multiple Modules Into One Single Code
####################################################

module "vpc" {
  source = "./modules/vpc"

  security_group_endpoints = module.security_groups.security_group_endpoints
  app_name                 = var.app_name
  env                      = var.env
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id   = module.vpc.vpc_id ## Mapping vpc_id variables with VPC Module's VPC ID Output / Expose
  vpc_cidr = module.vpc.vpc_cidr
  app_name = var.app_name
  env      = var.env
}

module "iam_roles" {
  source   = "./modules/iam_roles"
  app_name = var.app_name
  env      = var.env
}

module "alb" {
  source = "./modules/alb"

  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  security_groups_http = module.security_groups.http
  app_name             = var.app_name
  env                  = var.env
}

module "pemfile" {
  source   = "./modules/pemfile"
  app_name = var.app_name
  env      = var.env
}

module "ecs" {
  source = "./modules/ecs_with_ec2"

  ecs_task               = module.security_groups.ecs_task
  private_subnets        = module.vpc.private_subnets
  ecs_node_sg            = module.security_groups.ecs_node_sg
  ecsInstanceRoleProfile = module.iam_roles.ecsInstanceRoleProfile
  ecsInstanceRole        = module.iam_roles.ecsInstanceRole
  log_grp_name           = module.cloudWatch.log_name
  key_name               = module.pemfile.pemfile
  alb_target_grp_1       = module.alb.alb_target_grp_1
  alb_target_grp_2       = module.alb.alb_target_grp_2
  aws_region             = var.aws_region
  app_name               = var.app_name
  env                    = var.env
  ecs_ec2_type           = var.ecs_ec2_type
  asg_max_node           = var.asg_max_node
  asg_min_node           = var.asg_min_node
  ecr_image_url          = var.ecr_image_url
}

module "bastion" {
  source = "./modules/bastion"

  bastion_security_group = module.security_groups.bastion_security_group
  pemfile                = module.pemfile.pemfile
  public_subnets         = module.vpc.public_subnets
  app_name               = var.app_name
  env                    = var.env
  bastion_host_type      = var.bastion_host_type
}

module "cloudWatch" {
  source = "./modules/cloudwatch"

  ecs_cluster_name = module.ecs.ecs_cluster_name
}

module "s3_bucket" {
  source = "./modules/s3"

  app_name = var.app_name
  env      = var.env
}

module "rds-mysql" {
  source = "./modules/rds-mysql"

  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  rds_mysql_sg       = module.security_groups.rds_mysql_sg
  app_name           = var.app_name
  env                = var.env
  rds_instance_class = var.rds_instance_class
}