# Application security policy template
Use this guide to setup NSX-T security policy for applications.

## Setup
* Setup backend
```terraform
# Update backend.tf

terraform {
  backend "s3" {
    bucket         = "terraform-bucket"
    key            = "<Application name>/terraform.tfstate"
    region         = "us-west-2"
    profile        = "default"
    dynamodb_table = "dynamodb-terraform-statelock"
  }
}
```
