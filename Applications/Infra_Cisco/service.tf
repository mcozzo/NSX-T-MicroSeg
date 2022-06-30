# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "ms-ds-tcp" {
  display_name = "MS-DS-TCP"
}
data "nsxt_policy_service" "ms-ds-udp" {
  display_name = "MS-DS-UDP"
}
data "nsxt_policy_service" "ms-rpc-tcp" {
  display_name = "MS_RPC_TCP"
}
data "nsxt_policy_service" "ms-rpc-udp" {
  display_name = "MS_RPC_UDP"
}


# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "firepower" {
  description  = "Firepower > ISE. Cisco MGMT stuff. Provisioned by Terraform"
  display_name = "TF-Firepower"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-FPWR-ISE"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8910"]
  }
}
resource "nsxt_policy_service" "ise-agent" {
  description  = "ISE Agent. Cisco MGMT stuff. Provisioned by Terraform"
  display_name = "TF-ISE-Agent"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-ISE-Agent"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8910","9095"]
  }
}
resource "nsxt_policy_service" "ise-client" {
  description  = "ISE Agent. Cisco MGMT stuff. Provisioned by Terraform"
  display_name = "TF-ISE-Client"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-ISE-Client-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443","8905","9095"]
  }
  l4_port_set_entry {
    display_name      = "TF-ISE-Client-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["8905"]
  }
}
resource "nsxt_policy_service" "prime-client" {
  description  = "Prime Agent. Cisco MGMT stuff. Provisioned by Terraform"
  display_name = "TF-Prime-Client"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-Prime-Client-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9991","20828","20830"]
  }
  l4_port_set_entry {
    display_name      = "TF-Prime-Client-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["9991","20830"]
  }
}
