# Application security policy template
Use this guide to setup NSX-T security policy for applications.

## Dependencies
* Infra_Services (TF-HTTPS UDP)

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

* Set sequence number
  * Update `Applications/README.md`
  * Update `Applications/<Application name>/security.tf`
  ```terraform
    resource "nsxt_policy_security_policy" "policy1" {
      ...
        sequence_number = 2
      ...
    }
  ```
