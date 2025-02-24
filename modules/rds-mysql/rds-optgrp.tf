####################################################
# MySQL RDS Instance Option Group
####################################################
resource "aws_db_option_group" "mysql_option_group" {
  name                     = "${var.app_name}-${var.env}-mysql8-option-group"
  engine_name              = "mysql"
  major_engine_version     = "8.0"
  option_group_description = "MySQL 8.0 option group for ${var.app_name} ${var.env} environment"
}