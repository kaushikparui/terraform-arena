####################################################
# Get list of available AZs
####################################################
data "aws_availability_zones" "available_zones" {
  state = "available"
}

locals {
  azs_count = 2
  azs_names = data.aws_availability_zones.available_zones.names
}