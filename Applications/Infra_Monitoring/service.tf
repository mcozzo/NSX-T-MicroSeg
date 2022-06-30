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
data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}
data "nsxt_policy_service" "syslog" {
  display_name = "Syslog (TCP)"
}
data "nsxt_policy_service" "syslog-udp" {
  display_name = "Syslog (UDP)"
}
data "nsxt_policy_service" "syslog_server" {
  display_name = "Syslog-Server"
}
data "nsxt_policy_service" "syslog_server_udp" {
  display_name = "Syslog-Server-UDP"
}
data "nsxt_policy_service" "snmp-rx" {
  display_name = "SNMP-Recieve"
}
data "nsxt_policy_service" "snmp-tx" {
  display_name = "SNMP-Send"
}
data "nsxt_policy_service" "mssql" {
  display_name = "Microsoft SQL Server"
}
data "nsxt_policy_service" "rdp" {
  display_name = "RDP"
}
data "nsxt_policy_service" "smb" {
  display_name = "SMB"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "syslog-s" {
  description  = "Syslog/TLS. https://datatracker.ietf.org/doc/html/rfc5425 Provisioned by Terraform"
  display_name = "TF-Syslog-S"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-Syslog-S"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["6514"]
  }
}
resource "nsxt_policy_service" "prtg" {
  description  = "Provisioned by Terraform"
  display_name = "TF-PRTG"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-PRTG-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["135","1024-5000","5985","5986","8080","49152-65535","49154","23560"]
  }
  l4_port_set_entry {
    display_name      = "TF-PRTG-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["3391","3389"]
  }
}
