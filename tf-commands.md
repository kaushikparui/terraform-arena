
## Initiate, Plan & Execute

Initiate the **terraform**
```bash
  terraform init
```

Check terraform code formatting
```bash
  terraform fmt
```

Validate your terraform code
```bash
  terraform validate
```

Plan terraform code ## Change Environment File As Per Requirements (dev.tfvars / stag.tfvars / prod.tfvars)
```bash
  terraform plan -var-file="stag.tfvars" -out project-plan
```

Apply your terraform code
```bash
  terraform apply project-plan
```

Display Sensitive Outputs (password)
```bash
  terraform output --json | jq '.rds_password'
```
##
## Destroy

Plan terraform code destroy ## Change Environment File As Per Requirements (dev.tfvars / stag.tfvars / prod.tfvars)
```bash
  terraform plan -var-file="stag.tfvars" -destroy -out project-plan
```

Apply your terraform code
```bash
  terraform apply project-plan
```