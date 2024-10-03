
# Terraform Template (Azure Cloud : VM & DB)

This Terraform Template is consist of multiple files separated related to services for better management.
* database.tf
* output.tf
* providers.tf
* resource_group.tf
* ssh_key.tf
* variables.tf
* virtual_network.tf
* virtual_network_sg.tf
* vm.tf
---
## Template Documentation
  * Create Azure Resource Group
  * Create Azure Virtual Network
  * Create Azure Subnet
  * Create Azure Network Security Group
  * Create Azure Public IP
  * Create Azure Network Interface
      * Create Pem File and store in the local system directory
  * Create Azure Virtual Machine
  * Create Azure Flexible Server with MySQL 8.0
  * Update Azure Flexible Server Configuration For All IP Inbound
  * Output of this infrastructure
    --- 
  * Variables for the infrastructure are stored here
      * Virtual Machine Details
      * Database Details
      * Project Details
    ---
## Deployment

To deploy this project in terraform

First  make sure that you have mmade some changes in the template according to your project infrasturtue.

* initialize the terraform template
```bash
  terraform init
```
* Check the template formating
```bash
  terraform fmt
```
* Validate the template
```bash
  terraform validate
```
* Plan the template
```bash
  terraform plan -out "[project_name]-azure-infrasturtue"
```
* Apply the changes into cloud
```bash
  terraform apply -auto-approve
```