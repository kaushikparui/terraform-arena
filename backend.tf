terraform {
  backend "s3" {
    bucket         = "terraform-state-tflock"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true # Encrypts the state at rest
    use_lockfile   = true
    profile        = "terraform-deployer"
  }
}