terraform {
  backend "s3" {
    bucket = "viget-interns-iac"
    region = "us-east-1"
    key    = "spinet/terraform.tfstate"
  }
}
