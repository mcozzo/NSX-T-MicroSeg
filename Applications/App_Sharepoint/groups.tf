#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "bistrack-app" {
  display_name = "TF-App-Bistrack-App"
}
#===============================================================================
# VM objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_vm
#===============================================================================

#data "nsxt_policy_vm" "vm-name" {
#  display_name = "vm-name"
#}

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "sharepoint-app" {
  display_name = "TF-App-Sharepoint-App"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "sharepoint|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "app|tier"
    }
  }
}
resource "nsxt_policy_group" "sharepoint-web" {
  display_name = "TF-App-Sharepoint-Web"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "sharepoint|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "web|tier"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.250.2.11",
                      "10.2.15.115",
                      "10.2.15.116",
                      "10.250.2.50"
                      ]
    }
  }
}
resource "nsxt_policy_group" "sharepoint-app-email" {
  display_name = "TF-App-Sharepoint-App-Email"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "email|app"
          }
  }
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.15.210",
                      "10.250.2.59",
                      "10.2.15.10",
                      "10.250.2.62",
                      "10.2.15.130"
                      ]
    }
  }
}
resource "nsxt_policy_group" "app-sharepoint" {
  display_name = "TF-App-Sharepoint"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "sharepoint|app"
          }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.250.2.11",
                      "10.2.15.124",
                      "10.2.15.112",
                      "10.1.15.115",
                      "10.2.15.116",
                      "10.2.15.118",
                      "10.250.2.51",
                      "10.250.2.50"
                      ]
    }
  }
}
resource "nsxt_policy_group" "sharepoint-db" {
  display_name = "TF-App-Sharepoint-DB"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "sharepoint|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "db|tier"
    }
  }
}