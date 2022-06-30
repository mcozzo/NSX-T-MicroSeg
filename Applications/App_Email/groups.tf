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

resource "nsxt_policy_group" "email" {
  display_name = "TF-App-Email"
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
}
resource "nsxt_policy_group" "email-smtp-server" {
  display_name = "TF-App-Email-SMTP-Server"
  description  = "Allowed to send public SMTP. Terraform provisioned Group"
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
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "smtp|service"
    }
  }
}
resource "nsxt_policy_group" "email-smtp-sender" {
  display_name = "TF-App-Email-SMTP-Sender"
  description  = "Allowed to send SMTP to internal SMTP servers.  Terraform provisioned Group"
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
      value       = "smtp-sender|service"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [data.nsxt_policy_group.rdsh.path]
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
        "10.2.30.215",
        "10.10.9.42",
        "10.10.9.40",
        "10.21.10.0/24",
        "10.18.10.46",
        "10.19.10.0/24",
        "10.10.9.0/24",
        "10.15.9.30",
        "10.15.10.0/24",
        "10.13.9.0/24",
        "10.2.15.105",
        "10.2.30.210",
        "10.15.28.11",
        "10.15.9.0/24",
        "10.11.9.0/24",
        "10.12.9.0/24",
        "10.16.9.0/24",
        "10.18.9.0/24",
        "10.19.9.0/24",
        "10.10.9.35",
        "10.10.9.30",
        "10.12.10.0/24",
        "10.18.10.57",
        "10.11.9.42",
        "10.13.9.30",
        "10.16.10.30",
        "10.2.15.114",
        "10.18.30.60-10.18.30.62",
        "10.10.10.0/24",
        "10.12.10.41",
        "10.25.9.0/24",
        "10.2.30.118",
        "10.2.15.161",
        "10.2.15.70",
        "10.250.2.11",
        "10.19.10.30",
        "10.18.10.0/24",
        "10.10.10.99",
        "10.1.15.151-10.1.15.156",
        "10.22.10.0/24",
        "10.2.30.64",
        "10.250.2.59",
        "10.2.30.61",
        "10.2.30.60",
        "10.2.30.63",
        "10.2.30.62",
        "10.2.15.124",
        "10.2.15.201",
        "10.11.9.30",
        "10.21.9.0/24",
        "10.22.9.0/24",
        "10.2.30.115",
        "10.12.10.30",
        "10.16.10.0/24",
        "10.2.15.130",
        "10.18.10.30",
        "10.1.15.151",
        "10.11.10.0/24",
        "10.13.10.0/24",
        "10.10.15.201",
        "10.2.30.94",
        "10.2.30.95",
        "10.2.30.221",
        "10.25.10.0/24",
        "10.2.15.210"
      ]
    }
  }
}
resource "nsxt_policy_group" "email-web" {
  display_name = "TF-App-Email-Web"
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
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "web|service"
    }
  }
}
