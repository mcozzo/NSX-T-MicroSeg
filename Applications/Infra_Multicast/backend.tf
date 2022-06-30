terraform {
  backend "s3" {
    bucket         = "terraform-bucket"
    key            = "infra_multicast/terraform.tfstate"
    region         = "us-west-2"
    profile        = "default"
    dynamodb_table = "dynamodb-terraform-statelock"
  }
}
