
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-Backup"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 10

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-Rubrik:OUT"
    log_label             = "TF-Rubrik:OUT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.rubrik-wowrack.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              data.nsxt_policy_service.ms-ad-v1.path,
                              data.nsxt_policy_service.nfs.path,
                              data.nsxt_policy_service.nfs-udp.path,
                              data.nsxt_policy_service.ntp.path,
                              data.nsxt_policy_service.ntp-ts.path,
                              data.nsxt_policy_service.smtp.path,
                              data.nsxt_policy_service.smtp-tls.path,
                              data.nsxt_policy_service.snmp-send.path,
                              data.nsxt_policy_service.syslog.path,
                              data.nsxt_policy_service.syslog-udp.path,
                              data.nsxt_policy_service.vmw-tcp.path,
                              data.nsxt_policy_service.vmw-udp.path,
                              resource.nsxt_policy_service.iscsi.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Rubrik:IN"
    log_label             = "TF-Rubrik:IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.rubrik-wowrack.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.ms-ad-v1.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
