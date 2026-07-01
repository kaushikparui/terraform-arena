resource "digitalocean_database_cluster" "this"{
name=var.name
engine=var.db_engine
version=var.db_version
region=var.region
size=var.db_size
node_count=var.node_count
}