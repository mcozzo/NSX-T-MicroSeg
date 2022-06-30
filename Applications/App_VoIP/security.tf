#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-VoIP"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 4

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-VoIP:InterApp"
    log_label             = "TF-VoIP:InterApp"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip.path]
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
    display_name          = "TF-VoIP:ESXi"
    log_label             = "TF-VoIP:ESXi"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip-esxi.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.app-ftp.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.nfs-tcp.path,
                              data.nsxt_policy_service.nfs-udp.path,
                              data.nsxt_policy_service.nfs-client-tcp.path,
                              data.nsxt_policy_service.nfs-client-udp.path
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
    display_name          = "TF-VoIP:Backup"
    log_label             = "TF-VoIP:Backup"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip-app.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.app-ftp.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.ssh.path]
    action                = "ALLOW"
    #action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-VoIP:Email-IN"
    log_label             = "TF-VoIP:Email-IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.imap.path,
                              data.nsxt_policy_service.imap-ssl.path,
                              data.nsxt_policy_service.smtp.path,
                              data.nsxt_policy_service.smtp-tls.path
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
    display_name          = "TF-VoIP:VM-IN"
    log_label             = "TF-VoIP:VM-IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip-phones.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.cucm.path]
    action                = "ALLOW"
    #action                = "JUMP_TO_APPLICATION"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-VoIP:Trunks"
    log_label             = "TF-VoIP:Trunks"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip-routers.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.voip.path,
                              resource.nsxt_policy_service.sip.path,
                              resource.nsxt_policy_service.cucm.path
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
    display_name          = "TF-VoIP:SIP"
    log_label             = "TF-VoIP:SIP"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.sip5060.path,
                              data.nsxt_policy_service.sip5061.path,
                              resource.nsxt_policy_service.sip.path
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
    display_name          = "TF-VoIP:WebInbound"
    log_label             = "TF-VoIP:WebInbound"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.https8.path
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
    display_name          = "TF-VoIP:CallsOut"
    log_label             = "TF-VoIP:CallsOut"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.voip-out.path
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
    display_name          = "TF-VoIP:CSM"
    log_label             = "TF-VoIP:CSM"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["10.250.2.30"]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.csm.path
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
    display_name          = "TF-VoIP:FaxIn"
    log_label             = "TF-VoIP:FaxIn"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["10.2.15.161"]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.h323.path,
                              resource.nsxt_policy_service.sip.path
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
    display_name          = "TF-VoIP:PublicWeb"
    log_label             = "TF-VoIP:PublicWeb"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip.path]
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
  }
  rule {
    display_name          = "TF-VoIP:Inbound"
    log_label             = "TF-VoIP:Inbound"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["172.18.110.10"]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip-app.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.sip5060.path
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
resource "nsxt_policy_security_policy" "app" {
  display_name    = "TF-VoIP"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 2

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-A-VoIP:App"
    log_label             = "TF-A-VoIP:App"
    notes                 = "Consider removing TCP:7 Because https://www.speedguide.net/port.php?port=7 https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0374 https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0375"
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ntp.path,
                              data.nsxt_policy_service.ssh.path,
                              resource.nsxt_policy_service.icmpecho.path
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
    display_name          = "TF-A-VoIP:Phones"
    log_label             = "TF-A-VoIP:Phones"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.voip.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.voip.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.h323.path,
                              data.nsxt_policy_service.h323gw.path,
                              data.nsxt_policy_service.sip5060.path,
                              data.nsxt_policy_service.sip5061.path,
                              resource.nsxt_policy_service.sip.path
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
