aws_region      = "ap-south-1"
aws_profile     = "terraform-deployer"
app_name         = "devinfotech"
env              = "dev"
os_distribution  = "ubuntu-24.04"

deploy_frontend  = true
deploy_backend   = true
fe_instance_type = "t3.nano"
fe_ssd_size      = 30
be_instance_type = "t3.micro"
be_ssd_size      = 30

deploy_rds           = true
db_engine            = "postgres"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20

deploy_s3 = true
bucket_name       = "devinfotech-dev-bucket"