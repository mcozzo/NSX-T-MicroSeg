#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "environment" {
  display_name    = "TF-Outbound"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 19

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-Outbound:WEB-URL"
    log_label             = "TF-Outbound:WEB-URL"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [
                              data.nsxt_policy_context_profile.http.path,
                              data.nsxt_policy_context_profile.http2.path
                            ]
    services              = [
                            ]
    action                = "ALLOW"
    #action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Outbound:WEB"
    log_label             = "TF-Outbound:WEB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.https_udp.path
                            ]
    action                = "ALLOW"
    #action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}

resource "nsxt_policy_security_policy" "environment_drop" {
  display_name    = "TF-EnvDrop"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 200 #This should be the last rule

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-EnvDrop:Drop"
    log_label             = "TF-EnvDrop:Drop"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = []
    sources_excluded      = false
    destination_groups    = []
    destinations_excluded = false
    profiles              = []
    services              = [
                            ]
    action                = "REJECT"
    #action                = "JUMP_TO_APPLICATION"
    #disabled              = var.nsxt_rules_disabled
    disabled              = true #Manually enable this rule

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
resource "nsxt_policy_security_policy" "application_drop" {
  display_name    = "TF-AppDrop"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 200 #This should be the last rule

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-AppDrop:Drop"
    log_label             = "TF-AppDrop:Drop"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = []
    sources_excluded      = false
    destination_groups    = []
    destinations_excluded = false
    profiles              = []
    services              = [
                            ]
    action                = "REJECT"
    #action                = "JUMP_TO_APPLICATION"
    #disabled              = var.nsxt_rules_disabled
    disabled              = true #Manually enable this rule

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
