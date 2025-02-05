provider "aws" {
  region = "us-east-1"
}
module "keypair" {
  source        = "../modules/keypair"
  pem_file_name = "utrainskey.pem"
  the_key_name  = "utrainskey"
  // pem_file_permission = 500 (where this can be any permission)
}