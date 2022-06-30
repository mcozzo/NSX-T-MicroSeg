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
data "nsxt_policy_service" "syslog" {
  display_name = "Syslog (TCP)"
}
data "nsxt_policy_service" "syslog-udp" {
  display_name = "Syslog (UDP)"
}
data "nsxt_policy_service" "dns" {
  display_name = "DNS"
}
data "nsxt_policy_service" "dns-udp" {
  display_name = "DNS-UDP"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "aw-scanner" {
  description  = "Arctic Wolf managed risk scanner. https://docs.arcticwolf.com/scanner/scanner_faq.html Provisioned by Terraform"
  display_name = "TF-A-Service"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-AW-Scanner-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["1514"]
  }
}
