##############################################################
# Account Level Variables                (Not Using Now Leaving this as a template)
/*variable "subscription_id" {
  description = "Azure subscription"
  default     = "70739a49-0924-48eb-aed0-6d55f132e354"
  sensitive   = true
}
variable "client_id" {
  description = "Azure Client ID"
  default     = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
variable "client_secret" {
  description = "Azure Client Secret"
  default     = "XXXXXXXXXXXXXXXXXX"
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  default     = "54b2cf2c-02a7-4130-81fe-59104bee441e"
  sensitive   = true
}*/
##############################################################
# Infra Level Variables
variable "resource_group_name" {
  type    = string
  default = "parrot-resources"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "resource_group_location" {
  type    = string
  default = "Central India"
}
variable "virtual_network_name" {
  type    = string
  default = "parrot-network"
}
variable "subnet_name" {
  type    = string
  default = "parrot-subnet"
}
variable "network_security_group_name" {
  type    = string
  default = "parrot-nsg"
}
variable "public_ip_address" {
  type    = string
  default = "parrot-public-ip"
}
variable "network_interface" {
  type    = string
  default = "parrot-nic"
}
variable "network_interface_ip_config" {
  type    = string
  default = "parrot-ip-config"
}
variable "key_file_name" {
  type    = string
  default = "parrot-azure.pem"
}
##############################################################
# Virtual Machine (Instance) Variables
variable "vm_identifier" {
  type    = string
  default = "parrot-vm"
}
variable "vm_type" {
  type    = string
  default = "Standard_B1s"
}
variable "vm_publisher" {
  type    = string
  default = "Canonical"
}
variable "vm_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}
variable "vm_sku" {
  type    = string
  default = "22_04-lts-gen2"
}
variable "vm_disk" {
  type    = string
  default = "parrot-osdisk"
}
variable "vm_disk_size" {
  type    = number
  default = "30"
}
variable "vm_hostname" {
  type    = string
  default = "radiantglacier.site"
}
variable "vm_username" {
  type    = string
  default = "ubuntu"
}
##############################################################
# Database (Instance) Variables
variable "db_servername" {
  type    = string
  default = "parrot-db-mysql-server"
}
variable "db_sku" {
  type    = string
  default = "B_Standard_B1s"
}
variable "db_server_username" {
  type    = string
  default = "dbadminuser"
}
variable "db_server_password" {
  type    = string
  default = "Wink^900~"
}
variable "db_server_tag" {
  type    = string
  default = "development"
}
variable "db_server_size" {
  type    = number
  default = "20"
}
variable "db_name" {
  type    = string
  default = "parrot_db"
}