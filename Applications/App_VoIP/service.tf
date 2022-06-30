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
data "nsxt_policy_service" "nfs-tcp" {
  display_name = "NFS (TCP)"
}
data "nsxt_policy_service" "nfs-udp" {
  display_name = "NFS (UDP)"
}
data "nsxt_policy_service" "nfs-client-tcp" {
  display_name = "NFS Client"
}
data "nsxt_policy_service" "nfs-client-udp" {
  display_name = "NFS Client UDP"
}
data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}
data "nsxt_policy_service" "imap" {
  display_name = "IMAP"
}
data "nsxt_policy_service" "imap-ssl" {
  display_name = "IMAP_SSL"
}
data "nsxt_policy_service" "smtp" {
  display_name = "SMTP"
}
data "nsxt_policy_service" "smtp-tls" {
  display_name = "SMTP_TLS"
}
data "nsxt_policy_service" "sip5060" {
  display_name = "SIP 5060"
}
data "nsxt_policy_service" "sip5061" {
  display_name = "SIP 5061"
}
data "nsxt_policy_service" "h323" {
  display_name = "H323 Call Signaling"
}
data "nsxt_policy_service" "h323gw" {
  display_name = "H323 Gatekeeper Discovery"
}
data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "cucm" {
  description  = "Cisco Unity Connection. Provisioned by Terraform"
  display_name = "TF-VoIP-CUCM"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-CUCM-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["16384-21511"]
  }
}
resource "nsxt_policy_service" "sip" {
  description  = "Cisco SIP. Provisioned by Terraform"
  display_name = "TF-VoIP-SIP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-SIP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["1024-65535"]
  }
  l4_port_set_entry {
    display_name      = "TF-VoIP-SIP-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1024-65535"]
  }
}
resource "nsxt_policy_service" "voip" {
  description  = "Cisco VoIP. Provisioned by Terraform"
  display_name = "TF-VoIP-VoIP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-VoIP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["32768-61000"]
  }
  l4_port_set_entry {
    display_name      = "TF-VoIP-VoIP-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["24576-61000","58000"]
  }
}
resource "nsxt_policy_service" "https8" {
  description  = "HTTPS on off port. Provisioned by Terraform"
  display_name = "TF-VoIP-8https"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443"]
  }
}
resource "nsxt_policy_service" "voip-out" {
  description  = "Outbound calls. Provisioned by Terraform"
  display_name = "TF-VoIP-Outbound"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-Out-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["389","1024-65535"]
  }
  l4_port_set_entry {
    display_name      = "TF-VoIP-Out-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1024-65535"]
  }
}
resource "nsxt_policy_service" "csm" {
  description  = "Outbound calls. Provisioned by Terraform"
  display_name = "TF-VoIP-CSM"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-CSM-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["5222"]
  }
}
resource "nsxt_policy_service" "icmpecho" {
  description  = "Outbound calls. Provisioned by Terraform"
  display_name = "TF-VoIP-ICMPEcho"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-VoIP-ICMP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["7"]
  }
}
