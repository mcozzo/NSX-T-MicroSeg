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
data "nsxt_policy_service" "netbios-nameservice-tcp" {
  display_name = "NetBios Name Service (TCP)"
}
data "nsxt_policy_service" "netbios-nameservice-udp" {
  display_name = "NetBios Name Service (UDP)"
}
data "nsxt_policy_service" "netbios-session-tcp" {
  display_name = "NetBios Session Service (TCP)"
}
data "nsxt_policy_service" "netbios-session-udp" {
  display_name = "NetBios Session Service (UDP)"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "fileprint" {
  description  = "File Print. Provisioned by Terraform"
  display_name = "TF-FilePrint"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-FP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["49152-65535"]
  }

  l4_port_set_entry {
    display_name      = "TF-FP-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["49152-65535"]
  }
}
resource "nsxt_policy_service" "dfsn" {
  description  = "DFSN. https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements#ports-and-protocols Provisioned by Terraform"
  display_name = "TF-FilePrint-DFSN"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-DFSN-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["135","139","389","445","49152-65535","5722"]
  }

  l4_port_set_entry {
    display_name      = "TF-DFSN-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["138","389"]
  }
}
resource "nsxt_policy_service" "btprinters" {
  description  = "Provisioned by Terraform"
  display_name = "TF-BTPritners"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BTPrint-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9100"]
  }
}
