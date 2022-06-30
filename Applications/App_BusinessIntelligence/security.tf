#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "environment" {
  display_name    = "TF-BusinessIntelligence"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
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
    display_name          = "TF-BI:InterApp"
    log_label             = "TF-BI:InterApp"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bi.path]
    destinations_excluded = false
    profiles              = []
    services              = []
    #action                = "ALLOW"
    action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-BI:Connector-Out-URL"
    log_label             = "TF-BI:Connector-Out-URL"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi-connector.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [data.nsxt_policy_context_profile.azure.path]
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.amqp.path
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
    display_name          = "TF-BI:Connector-Out"
    log_label             = "TF-BI:Connector-Out"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi-connector.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.amqp.path
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
    display_name          = "TF-BI:MGMT"
    log_label             = "TF-BI:MGMT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.mgmt_devices.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bi.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.bi_mgmt.path
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
    display_name          = "TF-BI:OutboundWeb"
    log_label             = "TF-BI:OutboundWeb"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
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
  #This should get picked up with the default outbound rule.
  /*
  rule {
    display_name          = "TF-BI:WebOut"
    log_label             = "TF-BI:WebOut"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
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
  }#*/
}
resource "nsxt_policy_security_policy" "application" {
  display_name    = "TF-BusinessIntelligence"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
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
    display_name          = "TF-BI:DB Access"
    log_label             = "TF-BI:DB Access"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bi-reporting.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bi-db.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                                data.nsxt_policy_service.mssql.path,
                                resource.nsxt_policy_service.bi_db.path
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
