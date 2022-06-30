#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-WSUS"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 6

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-WSUS:Inside"
    log_label             = "TF-WSUS:Inside"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.wsus.path]
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
  rule {
    display_name          = "TF-WSUS:Outside"
    log_label             = "TF-WSUS:Outside"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [data.nsxt_policy_context_profile.wsus.path]
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
}
