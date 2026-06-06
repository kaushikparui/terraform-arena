variable "prefix" { 
    type = string 
}

variable "ami_id" { 
    type = string 
}

variable "deploy_frontend" { 
    type = bool 
}

variable "deploy_backend" { 
    type = bool 
}

variable "fe_instance_type" { 
    type = string 
}

variable "be_instance_type" { 
    type = string 
}

variable "fe_ssd_size" { 
    type = number 
}

variable "be_ssd_size" { 
    type = number 
}

variable "security_group_id" { 
    type = string 
}

variable "key_name" {
  type        = string
  description = "The name of the key pair passed from the pemfile module"
}