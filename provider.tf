####################################################
# Terraform Provider Details
####################################################
terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "5.17.0" }
  }
}

provider "aws" {
  profile = "default"
  #region  = "us-west-1"
  region = var.aws_region
}