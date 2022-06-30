#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
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

resource "nsxt_policy_group" "app-horizon" {
  display_name = "TF-App-Horizon"
  description  = "Terraform provisioned Group. Might be missing LS-Trusted users as a segment"
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
      value       = "horizon|app"
          }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [
        resource.nsxt_policy_group.horizon-connection.path,
        resource.nsxt_policy_group.horizon-db.path,
        resource.nsxt_policy_group.horizon-desktop.path,
        resource.nsxt_policy_group.horizon-gateway.path,
        resource.nsxt_policy_group.horizon-license.path,
        resource.nsxt_policy_group.horizon-rds.path,
        resource.nsxt_policy_group.horizon-site-connect.path
      ]
    }
  }

  /*criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.10.36",
                      "10.2.10.37",
                      "10.2.10.34",
                      "10.2.10.35",
                      "10.2.10.32",
                      "10.2.10.33",
                      "10.2.10.52",
                      "10.2.10.30",
                      "10.2.10.149",
                      "10.2.10.31",
                      "10.2.10.38",
                      "10.2.10.39",
                      "10.2.10.40",
                      "10.2.10.146",
                      "10.2.10.144",
                      "10.2.10.121",
                      "10.2.10.140",
                      "10.2.15.17",
                      "10.2.10.46",
                      "10.2.10.43",
                      "10.2.10.41",
                      "10.2.10.138",
                      "10.2.10.159",
                      "10.2.10.115",
                      "10.2.10.42",
                      "10.2.10.150",
                      "10.2.10.155",
                      "10.2.10.154",
                      "10.2.10.153",
                      "10.2.10.152",
                      "10.2.10.151"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-appvol" {
  display_name = "TF-App-Horizon-Appvol"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "appvol|service"
    }
  }

   /*  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.15.144",
                      "10.2.15.143"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-connection" {
  display_name = "TF-App-Horizon-Connection"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "connection_server|service"
    }
  }
  /*
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.15.140",
                      "10.2.15.141"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-db" {
  display_name = "TF-App-Horizon-DB"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "db|tier"
    }
  }
  /*
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.15.113"]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-desktop" {
  display_name = "TF-App-Horizon-Desktop"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "vdi_desktop|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = ["/infra/segments/LS-Trusted_Users_(10)"]
    }
  }

  /*
  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.10.36",
                      "10.2.10.37",
                      "10.2.10.34",
                      "10.2.10.35",
                      "10.2.10.32",
                      "10.2.10.33",
                      "10.2.10.52",
                      "10.2.10.30",
                      "10.2.10.149",
                      "10.2.10.31",
                      "10.2.10.38",
                      "10.2.10.39",
                      "10.2.10.40",
                      "10.2.10.146",
                      "10.2.10.144",
                      "10.2.10.121",
                      "10.2.10.140",
                      "10.2.15.17",
                      "10.2.10.46",
                      "10.2.10.43",
                      "10.2.10.41",
                      "10.2.10.138",
                      "10.2.10.159",
                      "10.2.10.115",
                      "10.2.10.42",
                      "10.2.10.150",
                      "10.2.10.155",
                      "10.2.10.154",
                      "10.2.10.153",
                      "10.2.10.152",
                      "10.2.10.151"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-gateway" {
  display_name = "TF-App-Horizon-Gateway"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "gateway_server|service"
    }
  }
  /*
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.250.2.61",
                      "10.250.2.60"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-license" {
  display_name = "TF-App-Horizon-License"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "licensing|service"
    }
  }
  /*
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.15.250"]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-rds" {
  display_name = "TF-App-Horizon-RDS"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "vdi_rds|service"
    }
  }

  /*
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.15.155",
                      "10.2.9.10",
                      "10.2.9.41",
                      "10.2.9.35"
                      ]
    }
  }#*/
}
resource "nsxt_policy_group" "horizon-site-connect" {
  display_name = "TF-App-Horizon-Site-Connect"
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
      value       = "horizon|app"
          }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "site_connector|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                      "10.2.30.70",
                      "10.2.30.71",
                      ]
    }
  }
}
resource "nsxt_policy_group" "vcenter" {
  display_name = "TF-App-Horizon-vCenter"
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
      value       = "vsphere|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.30.221"]
    }
  }
}
resource "nsxt_policy_group" "esxi" {
  display_name = "TF-App-Horizon-ESXi"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }
  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.30.181-10.2.30.186"]
    }
  }
}
