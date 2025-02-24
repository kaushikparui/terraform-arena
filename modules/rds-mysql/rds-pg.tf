####################################################
# MySQL RDS Instance Parameter Group
####################################################
resource "aws_db_parameter_group" "mysql_pg" {
  name        = "${var.app_name}-${var.env}-mysql-pg"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL 8.0 with slow query and error log enabled"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "2"
  }

  parameter {
    name  = "log_output"
    value = "TABLE"
  }

  parameter {
    name  = "log_error_verbosity"
    value = "3"
  }
}