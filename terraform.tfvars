region="lon1"
environment="dev"


## Frontend droplet
frontend_size="s-1vcpu-1gb"
frontend_name="frontend"
frontend_image="ubuntu-24-04-x64"
frontend_password="frontend-password"


## Backend droplet
backend_size="s-1vcpu-1gb"
backend_name="backend"
backend_image="ubuntu-24-04-x64"
backend_password="backend-password"


## Database
db_engine="pg"
db_version="18"
db_size="db-s-1vcpu-2gb"


## Storage Object
storage_name="terraform-arena-space"
storage_acl="private"