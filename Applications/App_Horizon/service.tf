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
data "nsxt_policy_service" "tftp" {
  display_name = "TFTP"
}
data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}
data "nsxt_policy_service" "dhcp-client" {
  display_name = "DHCP-Client"
}
data "nsxt_policy_service" "dns-udp" {
  display_name = "DNS-UDP"
}
data "nsxt_policy_service" "icmp-all" {
  display_name = "ICMP ALL"
}
data "nsxt_policy_service" "dns" {
  display_name = "DNS"
}
data "nsxt_policy_service" "ldap" {
  display_name = "LDAP"
}
data "nsxt_policy_service" "vm-pvoip" {
  display_name = "VMware-View-PCoIP"
}
data "nsxt_policy_service" "vm-pvoip-udp" {
  display_name = "VMware-View5.x-PCoIP-UDP"
}
data "nsxt_policy_service" "rdp" {
  display_name = "RDP"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "pxe" {
  description  = "pxe boot ports and services. Provisioned by Terraform"
  display_name = "TF-PXE-Boot"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-PXE-Boot-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["1286"]
  }
  l4_port_set_entry {
    display_name      = "TF-PXE-Boot-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1000-65535"]
  }
}
resource "nsxt_policy_service" "nvidia-service" {
  description  = "NVIDIA-Svr ports. Provisioned by Terraform"
  display_name = "TF-NVIDIA-service"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-NVIDIA-Service-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1947"]
  }
}
resource "nsxt_policy_service" "https-udp" {
  description  = "HTTPS-UDP ports. Provisioned by Terraform"
  display_name = "TF-HTTPS-UDP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HTTPS-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["433"]
  }
}
resource "nsxt_policy_service" "blast-outside" {
  description  = "Blast Outside ports. Provisioned by Terraform"
  display_name = "TF-Blast-Outside"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-Blast-Outside-TCP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["443","8443"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-Outside-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["443","8443"]
  }
}
resource "nsxt_policy_service" "blast-inside" {
  description  = "Blast Outside ports. Provisioned by Terraform"
  display_name = "TF-Blast-Outside"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-Blast-Inside-TCP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["22443","8443"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-Inside-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["22443","8443"]
  }
}
resource "nsxt_policy_service" "cloudconnector" {
  description  = "Cloud Connector ports. Provisioned by Terraform"
  display_name = "TF-HZN-Cloud-Connector"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HZN-Cloud-Conn-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["4002","33443"]
  }
}
resource "nsxt_policy_service" "desktop-cloudconnector" {
  description  = "Desktop Cloud Connector ports. Provisioned by Terraform"
  display_name = "TF-HZN-Desktop-Cloud-Connector"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HZN-Desktop-Cloud-Conn-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["11002"]
  }
}
resource "nsxt_policy_service" "desktop-connector" {
  description  = "Desktop Connector ports. Provisioned by Terraform"
  display_name = "TF-HZN-Desktop-Connector"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HZN-Desktop-Conn-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["4001","4002"]
  }
}
resource "nsxt_policy_service" "horizon-internal" {
  description  = "Horizon internal ports. Provisioned by Terraform"
  display_name = "TF-HZN-Horizon-Internal"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HZN-CDR-MMR-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9427"]
  }
  l4_port_set_entry {
    display_name      = "TF-HZN-USB-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["3211"]
  }
}
resource "nsxt_policy_service" "uag-rds" {
  description  = "Horizon UAG to Desktop RDS Hosts ports. Provisioned by Terraform"
  display_name = "TF-UGA-RDS"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-USB-Redirect-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["32111"]
  }
  l4_port_set_entry {
    display_name      = "TF-HTTPS-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["443"]
  }
  l4_port_set_entry {
    display_name      = "TF-HTTPS-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["443"]
  }
  l4_port_set_entry {
    display_name      = "TF-PCoIP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["4172"]
  }
  l4_port_set_entry {
    display_name      = "TF-PCoIP-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["4172"]
  }
  l4_port_set_entry {
    display_name      = "TF-MMR-CDR-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9427"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-TCP2"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["22443"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-UDP2"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["8443"]
  }
  l4_port_set_entry {
    display_name      = "TF-Blast-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["22443"]
  }
}