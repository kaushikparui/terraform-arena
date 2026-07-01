variable "name"{
    type=string
}
variable "region"{
    type=string
}
variable "size"{
    type=string
}
variable "image"{
    type=string
}
variable "frontend_password" {
  type      = string
  sensitive = true
}
variable "backend_password" {
  type      = string
  sensitive = true
}