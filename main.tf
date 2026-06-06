provider "aws" { 
  region = var.aws_region
  profile = var.aws_profile
}

# Lookup global AMI selection
data "aws_ami" "selected" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.os_distribution == "ubuntu-24.04" ? "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" : "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

####################################################
# STEP 1: securitygroups MODULE (Security Groups)
####################################################
module "securitygroups" {
  source = "./modules/securitygroups"
  prefix = "${var.app_name}-${var.env}"
}

####################################################
# STEP 2: PEMFILE MODULE (Key Generation & Download)
####################################################
module "pemfile" {
  source = "./modules/pemfile"
  prefix = "${var.app_name}-${var.env}"
}

####################################################
# STEP 3: COMPUTE MODULE (PEM Files & EC2 Instances)
# Waits for Security Groups to be fully available.
####################################################
module "compute" {
  source             = "./modules/compute"
  prefix             = "${var.app_name}-${var.env}"
  ami_id             = data.aws_ami.selected.id
  deploy_frontend    = var.deploy_frontend
  deploy_backend     = var.deploy_backend
  fe_instance_type   = var.fe_instance_type
  be_instance_type   = var.be_instance_type
  fe_ssd_size        = var.fe_ssd_size
  be_ssd_size        = var.be_ssd_size
  security_group_id  = module.securitygroups.ec2_sg_id
  key_name           = module.pemfile.pemfile_key_name

  # Enforce strict sequential order
  depends_on = [
    module.securitygroups,
    module.pemfile
  ]
}

####################################################
# STEP 4: DATABASE MODULE (RDS Instance)
# Waits for both Security Groups and EC2 Compute setup.
####################################################
module "database" {
  source            = "./modules/database"
  count             = var.deploy_rds ? 1 : 0
  prefix            = "${var.app_name}-${var.env}"
  engine            = var.db_engine
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  security_group_id = module.securitygroups.rds_sg_id
  
  # Leaving username blank triggers the automated fallback configuration inside the module
  username          = "" 

  depends_on = [
    module.securitygroups,
    module.compute
  ]
}

####################################################
# STEP 5: STORAGE MODULE (S3 Bucket)
# Can run in parallel or independently.
####################################################
module "storage" {
  source      = "./modules/storage"
  count       = var.deploy_s3 ? 1 : 0
  bucket_name = var.bucket_name
}