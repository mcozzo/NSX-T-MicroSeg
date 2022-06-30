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

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "igel" {
  description  = "https://www.igel.com/ Provisioned by Terraform"
  display_name = "TF-IGEL"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-IGEL-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443","9080","30001"]
  }
}
