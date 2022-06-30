
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-Cisco"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 5

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-Cisco:ISE-Server"
    log_label             = "TF-Cisco:ISE-Server"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.ise.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.ise.path]
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
    display_name          = "TF-Cisco:FPWR-ISE"
    log_label             = "TF-Cisco:FPWR-ISE"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.firepower.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.ise.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.firepower.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Cisco:ISE-AD"
    log_label             = "TF-Cisco:ISE-AD"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.app-ad.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.ise.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.ise-agent.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Cisco:ISE-Client"
    log_label             = "TF-Cisco:ISE-Client"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.ise.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ms-ds-tcp.path,
                              data.nsxt_policy_service.ms-ds-udp.path,
                              data.nsxt_policy_service.ms-rpc-tcp.path,
                              data.nsxt_policy_service.ms-rpc-udp.path,
                              resource.nsxt_policy_service.ise-client.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Cisco:Client-Prime"
    log_label             = "TF-Cisco:Client-Prime"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.prime.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.prime-client.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
