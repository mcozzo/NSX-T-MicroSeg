#===============================================================================
# Identify pre defined objects
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "app-activedirectory" {
  display_name = "TF-App-ActiveDirectory"
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
      value       = "active_directory|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.10.15.110", "10.16.15.110", "10.21.15.10", "10.2.15.41", "10.250.1.10", "10.32.15.110", "10.18.15.10", "10.25.15.10", "10.15.15.10", "10.19.15.10", "10.13.15.10", "10.22.15.10", "10.12.15.10", "10.2.15.111", "10.2.15.110", "10.1.15.110"]
    }
  }
}

resource "nsxt_policy_group" "app-dns" {
  display_name = "TF-App-DNS"
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
      value       = "dns|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [resource.nsxt_policy_group.app-activedirectory.path]
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
        "10.10.15.95",
        "10.10.15.110",
        "10.32.15.110",
        "10.250.1.10",
        "10.2.30.110",
        "10.2.15.111",
        "10.1.15.111",
        "10.2.15.110",
        "10.1.15.110"
      ]
    }
  }
}

resource "nsxt_policy_group" "app-ntp" {
  display_name = "TF-App-NTP"
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
      value       = "ntp|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [resource.nsxt_policy_group.app-activedirectory.path]
    }
  }
  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
        "10.253.1.1",
        "10.10.15.110",
        "10.2.15.41",
        "10.250.1.10",
        "10.2.15.204",
        "10.2.15.111",
        "10.253.2.1",
        "10.2.15.110",
        "10.1.15.110",
        "10.250.2.10"
      ]
    }
  }

}

resource "nsxt_policy_group" "app-dhcp" {
  display_name = "TF-App-DHCP"
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
      value       = "dhcp|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.30.140", "10.2.9.1", "10.2.10.1"]
    }
  }
}

resource "nsxt_policy_group" "app-adfs" {
  display_name = "TF-App-ADFS"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.16.74"]
    }
  }
}

resource "nsxt_policy_group" "app-webauth" {
  display_name = "TF-App-WebAuth"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.200.2.5"]
    }
  }
}
