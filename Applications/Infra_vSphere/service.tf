#===============================================================================
# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service
#===============================================================================

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "vmware-vmotion" {
  display_name = "VMware VMotion"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "vmware-vstorage" {
  description  = "TCP Ports for vStorage Provisioned by Terraform"
  display_name = "TF-VS:Storage"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VS:Storage"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["1525","4075","17800-17899","35800-35899"]
  }
}