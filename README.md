# NSX-T Security policy
Terraform NSX-T rules for various applications.

##
ToDo
* Translate more data to variables.
E.G.
```terraform
# ./Applications/App_FilePrint/groups.tf
resource "nsxt_policy_group" "fileprint" {
    criteria {
    ipaddress_expression {
      ip_addresses = ["10.0.0.11","10.0.0.12"]
      #Vs.
      ip_addresses = var.app_fileprint_servers
    }
  }
}
```
* Create tfvars for each site.
* Deploy onto CI/CD Infrastructure. Update / combine as needed.
