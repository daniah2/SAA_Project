terraform {
  backend "s3" {
    bucket       = "daniah-tf-state-2025"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
