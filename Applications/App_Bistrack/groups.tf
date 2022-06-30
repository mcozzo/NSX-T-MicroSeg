#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "rdsh" {
  display_name = "TF-App-RDSH"
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

resource "nsxt_policy_group" "bistrack" {
  display_name = "TF-App-Bistrack"
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
      value       = "bistrack|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [
                        resource.nsxt_policy_group.bistrack-app.path,
                        resource.nsxt_policy_group.bistrack-cc.path,
                        resource.nsxt_policy_group.bistrack-db.path,
                        resource.nsxt_policy_group.bistrack-pos.path,
                        resource.nsxt_policy_group.bistrack-web.path,
                        resource.nsxt_policy_group.bistrack-printers.path
                      ]
    }
  }
}
resource "nsxt_policy_group" "bistrack-app" {
  display_name = "TF-App-Bistrack-App"
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
      value       = "bistrack|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "app|tier"
    }
  }
}
resource "nsxt_policy_group" "bistrack-cc" {
  display_name = "TF-App-Bistrack-CC"
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
      value       = "bistrack|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "credit_card|service"
    }
  }
}
resource "nsxt_policy_group" "bistrack-db" {
  display_name = "TF-App-Bistrack-DB"
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
      value       = "bistrack|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "db|tier"
    }
  }
}
resource "nsxt_policy_group" "bistrack-pos" {
  display_name = "TF-App-Bistrack-POS"
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
      value       = "bistrack|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "pos|tier"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.1.15.151-10.1.15.156"]
    }
  }
}
resource "nsxt_policy_group" "bistrack-web" {
  display_name = "TF-App-Bistrack-Web"
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
      value       = "bistrack|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "web|tier"
    }
  }
}
resource "nsxt_policy_group" "bistrack-printers" {
  display_name = "TF-App-Bistrack-Printers"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                        "10.25.9.0/24",
                        "10.11.10.0/24",
                        "10.12.10.0/24",
                        "10.13.10.0/24",
                        "10.18.10.0/24",
                        "10.21.10.0/24",
                        "10.19.10.0/24",
                        "10.22.10.0/24",
                        "10.10.9.0/24",
                        "10.15.10.0/24",
                        "10.13.9.0/24",
                        "10.25.10.0/24",
                        "10.21.9.0/24",
                        "10.22.9.0/24",
                        "10.15.9.0/24",
                        "10.10.10.0/24",
                        "10.11.9.0/24",
                        "10.16.10.0/24",
                        "10.12.9.0/24",
                        "10.16.9.0/24",
                        "10.18.9.0/24",
                        "10.19.9.0/24"
                      ]
    }
  }
}
resource "nsxt_policy_group" "bistrack-erp" {
  display_name = "TF-App-Bistrack-ERP"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                        "10.25.13.0/24",
                        "10.18.13.0/24",
                        "10.12.13.0/24",
                        "10.13.13.0/24",
                        "10.21.13.0/24",
                        "10.16.13.0/24",
                        "10.22.13.0/24",
                        "10.15.13.0/24",
                        "10.19.13.0/24",
                        "10.10.13.0/24"
                      ]
    }
  }
}
