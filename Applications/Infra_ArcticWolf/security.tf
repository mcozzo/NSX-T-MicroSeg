#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-ArcticWolf"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 9

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-AW:ManagedRiskScanner"
    log_label             = "TF-AW:ManagedRiskScanner"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.aw-scanner.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = []
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-AW:ManagedRiskOut-URL"
    log_label             = "TF-AW:ManagedRiskOut-URL"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    #profiles              = [resource.nsxt_policy_context_profile.arctic-wolf-urls.path]
    profiles              = [data.nsxt_policy_context_profile.arctic-wolf-urls.path]
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.syslog.path,
                              data.nsxt_policy_service.syslog-udp.path,
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              resource.nsxt_policy_service.aw-scanner.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-AW:ManagedRiskOut"
    log_label             = "TF-AW:ManagedRiskOut"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.aw-public-ip.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.syslog.path,
                              data.nsxt_policy_service.syslog-udp.path,
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              resource.nsxt_policy_service.aw-scanner.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-AW:Catch"
    log_label             = "TF-AW:Catch"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [resource.nsxt_policy_service.aw-scanner.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
