#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-vSphere"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 11

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-VS:vMotion"
    log_label             = "TF-VS:vMotion"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.vmotion.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.vmotion.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.vmware-vmotion.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
    rule {
    display_name          = "TF-VS:Storage"
    log_label             = "TF-VS:Storage"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.vstorage.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.vstorage.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.vmware-vstorage.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
