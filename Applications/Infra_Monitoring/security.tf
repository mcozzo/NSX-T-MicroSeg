#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-Monitoring"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 8

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-Monitoring:Syslog"
    log_label             = "TF-Monitoring:Syslog"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.syslog.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.syslog.path,
                              data.nsxt_policy_service.syslog-udp.path,
                              resource.nsxt_policy_service.syslog-s.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Monitoring:SNMP-RX"
    log_label             = "TF-Monitoring:SNMP-RX"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.snmp.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.snmp-rx.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Monitoring:SNMP-TX"
    log_label             = "TF-Monitoring:SNMP-TX"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.snmp.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.snmp-tx.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Monitoring:DNG"
    log_label             = "TF-Monitoring:DNG"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.dng.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Monitoring:PRTG"
    log_label             = "TF-Monitoring:PRTG"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.prtg.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ssh.path,
                              data.nsxt_policy_service.syslog.path,
                              data.nsxt_policy_service.syslog-udp.path,
                              #data.nsxt_policy_service.syslog_server.path,
                              #data.nsxt_policy_service.syslog_server_udp.path,
                              data.nsxt_policy_service.snmp-rx.path,
                              data.nsxt_policy_service.snmp-tx.path,
                              data.nsxt_policy_service.mssql.path,
                              data.nsxt_policy_service.rdp.path,
                              data.nsxt_policy_service.smb.path,
                              resource.nsxt_policy_service.prtg.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
