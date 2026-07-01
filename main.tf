module "frontend" {
  source="./modules/droplet"
  name=var.frontend_name
  region=var.region
  size=var.frontend_size
  image=var.frontend_image
  frontend_password=var.frontend_password
}

module "backend" {
  source="./modules/droplet"
  name=var.backend_name
  region=var.region
  size=var.backend_size
  image=var.backend_image
  backend_password=var.backend_password
}

module "postgres" {
  source="./modules/postgres"
  name="postgres_db"
  region=var.region
  db_engine=var.db_engine
  db_version=var.db_version
  db_size=var.db_size
  node_count=1
  environment=var.environment
}

module "db_firewall" {
  source="./modules/database_firewall"
  cluster_id=module.postgres.id
  backend_droplet_id=module.backend.id
}

module "space" {
  source="./modules/object_storage"
  name=var.storage_name
  region=var.region
  acl=var.storage_acl
}
