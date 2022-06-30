terraform {
  backend "s3" {
    bucket         = "<Customer>-terraform"
    key            = "<Applicaiton name>/terraform.tfstate"
    #key            = "infra_<Infrastructure stuff>/terraform.tfstate"
    #key            = "app_<A specific application>/terraform.tfstate"
    region         = "us-west-2"
    profile        = "<Customer>"
    dynamodb_table = "<Customer>-dynamodb-terraform-statelock"
  }
}
