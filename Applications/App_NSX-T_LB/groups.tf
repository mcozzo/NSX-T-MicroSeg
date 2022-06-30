#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "ad" {
  display_name = "TF-App-ActiveDirectory"
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

resource "nsxt_policy_group" "nsxt_vip" {
  display_name = "TF-NSX-T_VIP"
  description  = "NSX-T Reserved address space:  https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws-networking-security/GUID-658253DB-F384-4040-94B2-DF2AC3C9D396.html https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws-networking-security/GUID-658253DB-F384-4040-94B2-DF2AC3C9D396.html Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      #ip_addresses = ["100.64.0.1","100.64.96.1"] # Specific VIP addresses
      ip_addresses = ["100.64.0.0/10"] # CGNAT subnet
    }
  }
}#*/
resource "nsxt_policy_group" "nsxt_reverseproxy" {
  display_name = "TF-NSX-T_ReverseProxy"
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
      value       = "reverse_proxy|app"
    }
  }
}#*/
