env                = "dev" ## Denoted as Development Environment
bastion_host_type  = "t2.nano"
ecs_ec2_type       = "t2.micro"
rds_instance_class = "db.t3.micro"
app_name           = "hrxd"
asg_min_node       = "1"
asg_max_node       = "1"
ecr_image_url      = "725873549359.dkr.ecr.us-west-1.amazonaws.com/multi_node:latest"
