#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

#data "nsxt_policy_group" "rfc1918" {
#  display_name = "RFC1918"
#}

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

resource "nsxt_policy_group" "vmotion" {
  display_name = "TF-App-ESXi-vMotion"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["192.168.60.0/26"]
    }
  }
}
resource "nsxt_policy_group" "vstorage" {
  display_name = "TF-App-ESXi-Storage"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.1.17.0/26"]
    }
  }
}
