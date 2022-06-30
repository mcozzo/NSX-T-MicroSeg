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
data "nsxt_policy_service" "exchange_client" {
  display_name = "MS Exchange 2010 Client Access Servers"
}
data "nsxt_policy_service" "pop3" {
  display_name = "POP3"
}
data "nsxt_policy_service" "smtp" {
  display_name = "SMTP"
}
data "nsxt_policy_service" "smtp_tls" {
  display_name = "SMTP_TLS"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

#resource "nsxt_policy_service" "some-service" {
#  description  = "A Service. Provisioned by Terraform"
#  display_name = "TF-A-Service"
#  tag {
#      scope = "managed-by"
#      tag   = "terraform"
#  }
#
#  l4_port_set_entry {
#    display_name      = "TF-A-Service-TCP"
#    description       = ""
#    protocol          = "TCP"
#    destination_ports = ["443"]
#  }
#
#  l4_port_set_entry {
#    display_name      = "TF-A-Service-UDP"
#    description       = ""
#    protocol          = "UDP"
#    destination_ports = ["443"]
#  }
#}
