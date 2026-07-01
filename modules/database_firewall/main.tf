resource "digitalocean_database_firewall" "this"{
cluster_id=var.cluster_id
rule{
type="droplet"
value=var.backend_droplet_id
}
}