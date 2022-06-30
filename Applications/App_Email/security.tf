#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-Email"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 6

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  #These were disabled in the source reference rules.
  #rule {
  #  display_name          = "TF-Email:WebOutContext"
  #  log_label             = "TF-Email:WebOutContext"
  #  notes                 = ""
  #  logged                = var.nsxt_enable_logging

  #  source_groups         = [resource.nsxt_policy_group.email.path]
  #  sources_excluded      = false
  #  destination_groups    = [data.nsxt_policy_group.rfc1918.path]
  #  destinations_excluded = true
  #  profiles              = [
  #                            data.nsxt_policy_context_profile.http.path,
  #                            data.nsxt_policy_context_profile.http2.path
  #                          ]
  #  services              = []
  #  action                = "ALLOW"
  #  #action                = "JUMP_TO_APPLICATION"
  #  disabled              = var.nsxt_rules_disabled

  #  tag {
  #      scope = "managed-by"
  #      tag   = "terraform"
  #  }
  #}
  #rule {
  #  display_name          = "TF-Email:WebOut"
  #  log_label             = "TF-Email:WebOut"
  #  notes                 = ""
  #  logged                = var.nsxt_enable_logging

  #  source_groups         = [resource.nsxt_policy_group.email.path]
  #  sources_excluded      = false
  #  destination_groups    = [data.nsxt_policy_group.rfc1918.path]
  #  destinations_excluded = true
  #  profiles              = []
  #  services              = [
  #                            data.nsxt_policy_service.http.path,
  #                            data.nsxt_policy_service.https.path
  #                          ]
  #  action                = "ALLOW"
  #  #action                = "JUMP_TO_APPLICATION"
  #  disabled              = var.nsxt_rules_disabled

  #  tag {
  #      scope = "managed-by"
  #      tag   = "terraform"
  #  }
  #}
  rule {
    display_name          = "TF-Email:WebMail-Public"
    log_label             = "TF-Email:WebMail-Public"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.email-web.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path
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
    display_name          = "TF-Email:Clients"
    log_label             = "TF-Email:Clients"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.email.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.exchange_client.path
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
    display_name          = "TF-Email:PHP-POP3"
    log_label             = "TF-Email:PHP-POP3"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.email-web.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.pop3.path
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
    display_name          = "TF-Email:SMTP-IN"
    log_label             = "TF-Email:SMTP-IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.email-smtp-server.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.smtp.path,
                              data.nsxt_policy_service.smtp_tls.path
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
    display_name          = "TF-Email:SMTP-OUT"
    log_label             = "TF-Email:SMTP-OUT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.email-smtp-server.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.smtp.path,
                              data.nsxt_policy_service.smtp_tls.path
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
    display_name          = "TF-Email:SMTP-Senders"
    log_label             = "TF-Email:SMTP-Senders"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.email-smtp-sender.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.email-smtp-server.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.smtp.path,
                              data.nsxt_policy_service.smtp_tls.path
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
#resource "nsxt_policy_security_policy" "app" {
#  display_name    = "TF-Email"
#  description     = "Terraform provisioned Security Policy"
#  #category        = "Infrastructure"
#  #category        = "Environment"
#  category        = "Application"
#  domain          = var.nsxt_domain
#  locked          = false
#  stateful        = true
#  tcp_strict      = false
#  sequence_number = 4
#
#  tag {
#      scope = "managed-by"
#      tag   = "terraform"
#  }
#
#  rule {
#    display_name          = "TF-DESCRIPTION:SOME-RULE"
#    log_label             = "TF-DESCRIPTION:SOME-RULE"
#    notes                 = ""
#    logged                = var.nsxt_enable_logging
#
#    source_groups         = [data.nsxt_policy_group.rfc1918.path]
#    sources_excluded      = false
#    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
#    destinations_excluded = false
#    profiles              = []
#    services              = [
#                              data.nsxt_policy_service.http.path,
#                              data.nsxt_policy_service.https.path
#                            ]
#    action                = "ALLOW"
#    #action                = "JUMP_TO_APPLICATION"
#    disabled              = var.nsxt_rules_disabled
#
#    tag {
#        scope = "managed-by"
#        tag   = "terraform"
#    }
#  }
#}
