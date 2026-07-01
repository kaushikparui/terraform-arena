variable "region"{
    type=string
}
variable "environment"{
    type=string
}


## Frontend droplet
variable "frontend_name"{
    type=string
}
variable "frontend_size"{
    type=string
}
variable "frontend_image"{
    type=string
}
variable "frontend_password" {
  sensitive = true
}


## Backend droplet
variable "backend_name"{
    type=string
}
variable "backend_size"{
    type=string
}
variable "backend_image"{
    type=string
}
variable "backend_password" {
  sensitive = true
}

## Database
variable "db_engine"{
    type=string
}
variable "db_version"{
    type=string
}
variable "db_size"{
    type=string
}


## Storage Object
variable "storage_name"{
    type=string
}
variable "storage_acl"{
    type=string
}