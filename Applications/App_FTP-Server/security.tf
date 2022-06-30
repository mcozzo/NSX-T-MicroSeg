
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded

# Environment rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-FTP"
  description     = "Terraform provisioned Security Policy"
  category        = "Environment"
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
    display_name          = "TF-FTP:InterApp"
    source_groups         = [nsxt_policy_group.app-ftp.path]
    sources_excluded      = false
    destination_groups    = [nsxt_policy_group.app-ftp.path]
    destinations_excluded = false
    services              = []
    action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-FTP:InterApp"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-FTP:Public"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [nsxt_policy_group.app-ftp-external.path]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.ftp.path, resource.nsxt_policy_service.ftp_passive.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-FTP:Public"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name       = "TF-FTP:Internal"
    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [nsxt_policy_group.app-ftp-internal.path]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.ssh.path, data.nsxt_policy_service.ftp.path, resource.nsxt_policy_service.ftp_passive.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-FTP:Internal"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}

# Application rules
resource "nsxt_policy_security_policy" "policy2" {
  display_name    = "TF-FTP"
  description     = "Terraform provisioned Security Policy"
  category        = "Application"
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
    display_name          = "TF-A-FTP:FTP-Proxy"
    source_groups         = [nsxt_policy_group.app-ftp-internal.path]
    sources_excluded      = false
    destination_groups    = [nsxt_policy_group.app-ftp-external.path]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.ftp_proxy.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-A-FTP:FTP-Proxy"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-FTP:Proxy-FTP"
    source_groups         = [nsxt_policy_group.app-ftp-external.path]
    sources_excluded      = false
    destination_groups    = [nsxt_policy_group.app-ftp-internal.path]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.ftp.path, resource.nsxt_policy_service.ftp_passive.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    logged                = var.nsxt_enable_logging
    log_label             = "TF-A-FTP:Proxy-FTP"
    notes                 = ""

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }

}
