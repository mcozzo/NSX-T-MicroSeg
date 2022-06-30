terraform {
  backend "s3" {
    bucket         = "terraform-bucket"
    key            = "app_ftp-server/terraform.tfstate"
    region         = "us-west-2"
    profile        = "default"
    dynamodb_table = "dynamodb-terraform-statelock"
  }
}
