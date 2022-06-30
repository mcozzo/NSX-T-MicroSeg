# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "dns" {
  display_name = "DNS"
}
data "nsxt_policy_service" "dns-udp" {
  display_name = "DNS-UDP"
}
data "nsxt_policy_service" "syslog" {
  display_name = "Syslog (TCP)"
}
data "nsxt_policy_service" "syslog-udp" {
  display_name = "Syslog (UDP)"
}
data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}
data "nsxt_policy_service" "ntp-ts" {
  display_name = "NTP Time Server"
}
data "nsxt_policy_service" "ms-ad-v1" {
  display_name = "Microsoft Active Directory V1"
}
data "nsxt_policy_service" "nfs" {
  display_name = "NFS (TCP)"
}
data "nsxt_policy_service" "nfs-udp" {
  display_name = "NFS (UDP)"
}
data "nsxt_policy_service" "smtp" {
  display_name = "SMTP"
}
data "nsxt_policy_service" "smtp-tls" {
  display_name = "SMTP_TLS"
}
data "nsxt_policy_service" "snmp-send" {
  display_name = "SNMP-Send"
}
data "nsxt_policy_service" "vmw-tcp" {
  display_name = "VMware-ESXi5.x-TCP"
}
data "nsxt_policy_service" "vmw-udp" {
  display_name = "VMware-ESXi5.x-UDP"
}

# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "iscsi" {
  description  = "iSCSI TCP. Provisioned by Terraform"
  display_name = "TF-iSCSI"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-iSCSI-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["860"]
  }

  l4_port_set_entry {
    display_name      = "TF-iSCSI-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["860"]
  }
}
