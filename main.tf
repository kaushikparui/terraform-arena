####################################################
# Compiling Multiple Modules Into One Single Code
####################################################

module "vpc" {
  source = "./modules/vpc"

  security_group_endpoints = module.security_groups.security_group_endpoints
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id   = module.vpc.vpc_id    ## Mapping vpc_id variables with VPC Module's VPC ID Output / Expose
  vpc_cidr = module.vpc.vpc_cidr
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
  alb_target_grp         = module.alb.alb_target_grp
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "alb" {
  source = "./modules/alb"

  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  security_groups_http = module.security_groups.http
}

module "pemfile" {
  source = "./modules/pemfile"
}

module "bastion" {
  source = "./modules/bastion"

  bastion_security_group = module.security_groups.bastion_security_group
  pemfile                = module.pemfile.pemfile
  public_subnets         = module.vpc.public_subnets
}

module "cloudWatch" {
  source = "./modules/cloudwatch"

  ecs_cluster_name = module.ecs.ecs_cluster_name
}