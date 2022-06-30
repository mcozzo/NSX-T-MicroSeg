# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service

data "nsxt_policy_service" "icmpall" {
  display_name = "ICMP ALL"
}
data "nsxt_policy_service" "dns" {
  display_name = "DNS"
}
data "nsxt_policy_service" "dns-udp" {
  display_name = "DNS-UDP"
}
data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}
data "nsxt_policy_service" "ntp-ts" {
  display_name = "NTP Time Server"
}
data "nsxt_policy_service" "dhcp-server" {
  display_name = "DHCP-Server"
}
data "nsxt_policy_service" "dhcpv6-server" {
  display_name = "DHCPv6 Server"
}
data "nsxt_policy_service" "dhcp-client" {
  display_name = "DHCP-Client"
}
data "nsxt_policy_service" "dhcpv6-client" {
  display_name = "DHCPv6 Client"
}
data "nsxt_policy_service" "netbios-datagram-tcp" {
  display_name = "NetBios Datagram (TCP)"
}
data "nsxt_policy_service" "netbios-datagram-udp" {
  display_name = "NetBios Datagram (UDP)"
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
data "nsxt_policy_service" "ms-ad-v1" {
  display_name = "Microsoft Active Directory V1"
}


# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "TF-dns-tls" {
  description  = "DNS over TLS. https://en.wikipedia.org/wiki/DNS_over_TLS Provisioned by Terraform"
  display_name = "TF-DNS_over_TLS"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-DNS_over_TLS"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["853"]
  }
}

resource "nsxt_policy_service" "dhcp-failover" {
  description  = "DHCP Failover. https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn338987(v=ws.11) Provisioned by Terraform"
  display_name = "TF-DHCP-Failover"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-DHCP-Failover-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["647"]
  }

  l4_port_set_entry {
    display_name      = "TF-DHCP-Failover-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["647"]
  }
}

resource "nsxt_policy_service" "webauth" {
  description  = "WebAuth custom service Provisioned by Terraform"
  display_name = "TF-WebAuth"

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-WebAuth"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["885"]
  }
}
