variable "prefix"            { type = string }
variable "engine"            { type = string } 
variable "instance_class"    { type = string }
variable "allocated_storage" { type = number }
variable "security_group_id" { type = string }
variable "db_name" { 
    type = string
    default = "" 
}
variable "username" { 
    type = string
    default = "" 
} # Default empty to trigger auto-selection