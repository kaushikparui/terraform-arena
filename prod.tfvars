env                = "prod" ## Denoted as Production Environment
bastion_host_type  = "t3.nano"
ecs_ec2_type       = "t3.micro"
rds_instance_class = "db.t3.micro"
app_name           = "hrxd"
asg_min_node       = "1"
asg_max_node       = "2"
ecr_image_url      = "725873549359.dkr.ecr.us-west-1.amazonaws.com/multi_node:latest"