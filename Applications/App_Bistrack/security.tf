#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

#data.nsxt_policy_group.rfc1918.path
#resource.nsxt_policy_group.bistrack.path
#resource.nsxt_policy_group.bistrack-app.path
#resource.nsxt_policy_group.bistrack-cc.path
#resource.nsxt_policy_group.bistrack-db.path
#resource.nsxt_policy_group.bistrack-pos.path
#resource.nsxt_policy_group.bistrack-web.path
#resource.nsxt_policy_group.bistrack-printers.path

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-Bistrack"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
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
    display_name          = "TF-Bistrack:Print"
    log_label             = "TF-Bistrack:Print"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-printers.path]
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
    display_name          = "TF-Bistrack:App-Upload-Inside"
    log_label             = "TF-Bistrack:App-Upload-Inside"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ftp.path,
                              resource.nsxt_policy_service.ftp-pasv.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:App-Upload-Public"
    log_label             = "TF-Bistrack:App-Upload-Public"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ftp.path,
                              resource.nsxt_policy_service.ftp-pasv.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:App-Upload-Catch"
    log_label             = "TF-Bistrack:App-Upload-Catch"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = ["159.66.162.49","138.91.158.157"]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ftp.path,
                              resource.nsxt_policy_service.ftp-pasv.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:Scan Guns"
    log_label             = "TF-Bistrack:Scan Guns"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-erp.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-app.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [resource.nsxt_policy_service.bistrack-scangun.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:Monitor-RTI-SVC"
    log_label             = "TF-Bistrack:Monitor-RTI-SVC"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rdsh.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-web.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [resource.nsxt_policy_service.rti.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:GP-Dynamics"
    log_label             = "TF-Bistrack:GP-Dynamics"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rdsh.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [resource.nsxt_policy_service.dynamics.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:Outside-Web"
    log_label             = "TF-Bistrack:Outside-Web"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.bistrack-web.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
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
    display_name          = "TF-Bistrack:Inside-Web"
    log_label             = "TF-Bistrack:Inside-Web"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-web.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
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
    display_name          = "TF-Bistrack:FTP-OUT"
    log_label             = "TF-Bistrack:FTP-OUT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-app.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = [
                              data.nsxt_policy_service.ftp.path,
                              resource.nsxt_policy_service.ftp-pasv.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-Bistrack:InterApp"
    log_label             = "TF-Bistrack:InterApp"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack.path]
    destinations_excluded = false
    #profiles              = [data.nsxt_policy_context_profile.bistrack.path]
    services              = []
    action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}

resource "nsxt_policy_security_policy" "app" {
  display_name    = "TF-Bistrack"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
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
    display_name          = "TF-A-Bistrack:Client"
    log_label             = "TF-A-Bistrack:Client"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack-pos.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-cc.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.bistrack-cc.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-Bistrack:SQL"
    log_label             = "TF-A-Bistrack:SQL"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack-db.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.mssql.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  # A catch rule exists. This can be deleted in the future because it shouldn't be in use.
  rule {
    display_name          = "TF-A-Bistrack:Catch"
    log_label             = "TF-A-Bistrack:Catch"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.bistrack.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.bistrack.path]
    destinations_excluded = false
    profiles              = []
    services              = []
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled
    #disabled              = true

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
