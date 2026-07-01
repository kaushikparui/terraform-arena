resource "digitalocean_droplet" "frontend" {

  name   = var.name
  region = var.region
  image  = var.image
  size   = var.size

  monitoring = true

  # No ssh_keys block

  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    root_password = var.frontend_password
  })

  tags = [
    var.name
  ]
}


resource "digitalocean_droplet" "backend" {

  name   = var.name
  region = var.region
  image  = var.image
  size   = var.size

  monitoring = true

  # No ssh_keys block

  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    root_password = var.backend_password
  })

  tags = [
    var.name
  ]
}