// Create a backend for this project//
terraform {
  backend "s3" {
    bucket         = "lbproject"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}