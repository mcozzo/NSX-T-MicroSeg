
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-Multicast"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
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
    display_name          = "TF-BLOCK-UPnP"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = ["224.0.0.0-239.255.255.255"]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.TF-UPnP.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-BLOCK-UPnP"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-BLOCK-mDNS"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = ["224.0.0.0-239.255.255.255"]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.TF-mDNS.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-BLOCK-mDNS"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name       = "TF-BLOCK-LLMNR"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = ["224.0.0.0-239.255.255.255"]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.TF-LLMNR.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-BLOCK-LLMNR"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name       = "TF-Allow-Multicast"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = ["224.0.0.0-239.255.255.255"]
    destinations_excluded = false
    services              = []
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-Allow-Multicast"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
