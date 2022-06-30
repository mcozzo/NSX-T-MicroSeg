#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "mgmt_devices" {
  display_name = "TF-MGMT-Devices"
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

resource "nsxt_policy_group" "bi" {
  display_name = "TF-App-BusinessIntelligence"
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
      value       = "bi|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [
        resource.nsxt_policy_group.bi-connector.path,
        resource.nsxt_policy_group.bi-db.path,
        resource.nsxt_policy_group.bi-reporting.path
      ]
    }
  }
}
resource "nsxt_policy_group" "bi-connector" {
  display_name = "TF-App-BusinessIntelligence-connector"
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
      value       = "bi|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "site_connector|service"
    }
  }
}
resource "nsxt_policy_group" "bi-db" {
  display_name = "TF-App-BusinessIntelligence-DB"
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
      value       = "bi|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "db|tier"
    }
  }
}
resource "nsxt_policy_group" "bi-reporting" {
  display_name = "TF-App-BusinessIntelligence-Reporting"
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
      value       = "bi|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "reporting|service"
    }
  }
}
