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

/*
data "nsxt_policy_vm" "vm-name" {
  display_name = "vm-name"
}#*/

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

/*
resource "nsxt_policy_group" "SOME-APP" {
  display_name = "TF-SOME-APP"
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
      ip_addresses = ["1.1.1.1", "2.2.2.2"]
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
    external_id_expression {
      member_type  = "VirtualMachine"
      external_ids = [data.nsxt_policy_vm.vm-name.id]
    }
  }
}#*/
