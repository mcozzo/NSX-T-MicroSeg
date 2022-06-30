#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "rubrik-wowrack" {
  display_name = "TF-Rubrik-Wowrack"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }
#
#  criteria {
#    condition {
#      key         = "Tag"
#      member_type = "VirtualMachine"
#      operator    = "EQUALS"
#      value       = "active_directory|app"
#    }
#  }
#
#  conjunction {
#    operator = "OR"
#  }
#
  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.29.6-10.2.29.28"]
    }
  }
#
#  conjunction {
#    operator = "OR"
#  }
#
#  criteria {
#    path_expression {
#      member_paths = [resource.nsxt_policy_group.app-activedirectory.path]
#    }
#  }
}
