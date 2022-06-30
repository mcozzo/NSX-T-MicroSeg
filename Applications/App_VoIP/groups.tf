#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "app-ftp" {
  display_name = "TF-App-FTP"
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

resource "nsxt_policy_group" "voip" {
  display_name = "TF-App-VoIP"
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
      value       = "voip|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.10.15.200","10.10.15.201","10.10.15.202"]
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [
        resource.nsxt_policy_group.voip-app.path,
        resource.nsxt_policy_group.voip-fax.path,
        resource.nsxt_policy_group.voip-phones.path
      ]
    }
  }
}
resource "nsxt_policy_group" "voip-app" {
  display_name = "TF-App-VoIP-App"
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
      value       = "voip|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "app|tier"
    }
  }
}

resource "nsxt_policy_group" "voip-fax" {
  display_name = "TF-App-VoIP-Fax"
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
      value       = "voip|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "fax|service"
    }
  }
}
resource "nsxt_policy_group" "voip-phones" {
  display_name = "TF-App-VoIP-Phones"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                        "10.10.7.0/24",
                        "10.11.7.0/24",
                        "10.12.7.0/24",
                        "10.13.7.0/24",
                        "10.15.7.0/24",
                        "10.16.7.0/24",
                        "10.18.7.0/24",
                        "10.19.7.0/24",
                        "10.21.7.0/24",
                        "10.22.7.0/24",
                        "10.25.7.0/24"
                      ]
    }
  }
}
resource "nsxt_policy_group" "voip-esxi" {
  display_name = "TF-App-VoIP-ESXi"
  description  = "ESXi hosts. Not sure how well that will work with VMC. Terraform provisioned Group"
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
resource "nsxt_policy_group" "voip-routers" {
  display_name = "TF-App-VoIP-Routers"
  description  = "Update for locale. Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
                        "10.253.21.1",
                        "10.253.22.1",
                        "10.253.10.1",
                        "10.253.16.1",
                        "10.253.19.1",
                        "10.253.18.1",
                        "10.253.13.1",
                        "10.253.12.1",
                        "10.253.15.1",
                        "10.253.25.1",
                        "10.253.2.1",
                        "10.253.1.1"
                      ]
    }
  }
}
