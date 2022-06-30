#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-RDP"
  description     = "Terraform provisioned Security Policy"
  category        = "Environment"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 1

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-RDP:Server-Public"
    log_label             = "TF-RDP:Server-Public"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.rdsh.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.rdp.path,
                              data.nsxt_policy_service.rdp-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-RDP:Server-Internal"
    log_label             = "TF-RDP:Server-Internal"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.rdsh.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.rdp.path,
                              data.nsxt_policy_service.rdp-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
