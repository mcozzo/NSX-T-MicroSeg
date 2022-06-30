#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-Sharepoint"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
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
    display_name          = "TF-SP:Connectors-In"
    log_label             = "TF-SP:Connectors-In"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-app.path]
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
    display_name          = "TF-SP:Public-Web"
    log_label             = "TF-SP:Public-Web"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.sharepoint-web.path]
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
    display_name          = "TF-SP:App"
    log_label             = "TF-SP:App"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-sharepoint.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-sharepoint.path]
    destinations_excluded = false
    profiles              = []
    services              = []
    action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SP:Inside-Web"
    log_label             = "TF-SP:Inside-Web"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-web.path]
    destinations_excluded = false
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
    display_name          = "TF-SP:Printing"
    log_label             = "TF-SP:Printing"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-app.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.sp-printing.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SP:Web-Email"
    log_label             = "TF-SP:Web-Email"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-web.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-app-email.path]
    destinations_excluded = false
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
    display_name          = "TF-SP:Outbound"
    log_label             = "TF-SP:Outbound"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-sharepoint.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
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
resource "nsxt_policy_security_policy" "app" {
  display_name    = "TF-Sharepoint"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 3

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-A-SP:Web-DB"
    log_label             = "TF-A-SP:Web-DB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-web.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-db.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.mssqls.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-SP:Web-App"
    log_label             = "TF-A-SP:Web-App"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-web.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.sharepoint2010v1.path,
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.sp-webservices.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
    rule {
    display_name          = "TF-A-SP:App-App"
    log_label             = "TF-A-SP:App-App"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-app.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-app.path]
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
    display_name          = "TF-A-SP:App-DB"
    log_label             = "TF-A-SP:App-DB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-app.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-db.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.mssqls.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
      rule {
    display_name          = "TF-A-SP:App-Web"
    log_label             = "TF-A-SP:App-Web"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.sharepoint-app.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.sharepoint-web.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                            data.nsxt_policy_service.sharepoint2010v1.path,
                            data.nsxt_policy_service.msreplication.path,
                            resource.nsxt_policy_service.sp-app-web.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
      rule {
    display_name          = "TF-A-SP:App-Service"
    log_label             = "TF-A-SP:App-Service"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-sharepoint.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-sharepoint.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.sharepoint2010v1.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
