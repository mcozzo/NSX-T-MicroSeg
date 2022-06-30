terraform {
  backend "s3" {
    bucket         = "terraform-bucket"
    key            = "app_sharepoint/terraform.tfstate"
    #key            = "infra_<Infrastructure stuff>/terraform.tfstate"
    #key            = "app_<A specific application>/terraform.tfstate"
    region         = "us-west-2"
    profile        = "default"
    dynamodb_table = "dynamodb-terraform-statelock"
  }
}
