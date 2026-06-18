# Terraform Arena

A modular Terraform project for provisioning cloud infrastructure using reusable Terraform modules.

## Project Structure

```text
terraform-arena/
├── backend.tf
├── main.tf
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── database
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── pemfile
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── securitygroups
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── storage
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── terraform.tfvars
└── variables.tf
```

---

## Overview

This repository follows a modular Terraform architecture to provision and manage cloud resources efficiently. Each infrastructure component is isolated into its own reusable module, making the codebase scalable, maintainable, and easy to extend.

## Modules

### Compute Module

Responsible for provisioning compute resources such as virtual machines or instances.

**Files:**

* `main.tf` – Resource definitions
* `variables.tf` – Input variables
* `outputs.tf` – Exported outputs

---

### Database Module

Creates and manages database resources.

**Files:**

* `main.tf`
* `variables.tf`
* `outputs.tf`

---

### Security Groups Module

Defines network security rules and firewall configurations.

**Files:**

* `main.tf`
* `variables.tf`
* `outputs.tf`

---

### Storage Module

Creates storage resources such as buckets, volumes, or object storage.

**Files:**

* `main.tf`
* `variables.tf`
* `outputs.tf`

---

### PEM File Module

Handles SSH key pair generation and PEM file management.

**Files:**

* `main.tf`
* `variables.tf`
* `outputs.tf`

---

## Root Configuration Files

| File               | Purpose                          |
| ------------------ | -------------------------------- |
| `main.tf`          | Calls all infrastructure modules |
| `variables.tf`     | Global variable definitions      |
| `terraform.tfvars` | Variable values for deployment   |
| `outputs.tf`       | Aggregated outputs from modules  |
| `backend.tf`       | Terraform backend configuration  |

---

## Prerequisites

* Terraform >= 1.5
* Cloud Provider Account (AWS/Azure/GCP)
* Appropriate credentials configured

Verify Terraform installation:

```bash
terraform version
```

---

## Usage

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Execution Plan

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## Backend Configuration

The backend configuration is maintained in:

```text
backend.tf
```

This file stores Terraform state remotely to enable:

* Team collaboration
* State locking
* State versioning
* Disaster recovery

---

## Variables

Update deployment-specific values in:

```text
terraform.tfvars
```

Example:

```hcl
project_name = "terraform-arena"
environment  = "dev"
region       = "ap-south-1"
```

---

## Outputs

After successful deployment:

```bash
terraform output
```

Example outputs may include:

* Instance IDs
* Public IPs
* Database Endpoints
* Security Group IDs
* Storage Bucket Names

---

## Best Practices Followed

* Modular architecture
* Reusable infrastructure components
* Separation of concerns
* Environment-specific configurations
* Centralized variable management
* Remote state management

---

## Future Enhancements

* Multiple environment support (Dev/Stage/Prod)
* CI/CD integration with GitHub Actions
* Terraform Cloud support
* Automated security scanning
* Infrastructure testing

---

## Author

**Kaushik Parui**

DevOps | Cloud | Infrastructure as Code

Portfolio: https://www.kaushikparui.com
