#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-Horizon"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 13

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-HZN:PXE"
    log_label             = "TF-HZN:PXE"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["10.2.30.140"]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-desktop.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.pxe.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.dhcp-client.path,
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              data.nsxt_policy_service.icmp-all.path,
                              data.nsxt_policy_service.ntp.path,
                              data.nsxt_policy_service.tftp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:Inter App"
    log_label             = "TF-HZN:Inter App"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-horizon.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-horizon.path]
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
    display_name          = "TF-HZN:LB_SNAT"
    log_label             = "TF-HZN:LB_SNAT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["100.65.96.1"]
    sources_excluded      = false
    destination_groups    = [
                              resource.nsxt_policy_group.horizon-connection.path,
                              resource.nsxt_policy_group.horizon-appvol.path
                            ]
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
    display_name          = "TF-HZN:NVIDIA-Svr"
    log_label             = "TF-HZN:NVIDIA-Svr"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-license.path]
    sources_excluded      = false
    destination_groups    = ["10.2.15.255"]
    destinations_excluded = false
    services              = [resource.nsxt_policy_service.nvidia-service.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:UAG-LB"
    log_label             = "TF-HZN:UAG-LB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-gateway.path]
    sources_excluded      = false
    destination_groups    = ["10.2.16.72"]
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
    display_name          = "TF-HZN:Client-UAG"
    log_label             = "TF-HZN:Client-UAG"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = true
    destination_groups    = [resource.nsxt_policy_group.horizon-gateway.path]
    destinations_excluded = false
    services              = [
                              resource.nsxt_policy_service.blast-outside.path,
                              data.nsxt_policy_service.vm-pvoip-udp.path,
                              resource.nsxt_policy_service.https-udp.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.vm-pvoip.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:Desktop-OUT"
    log_label             = "TF-HZN:Desktop-OUT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-desktop.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    services              = []
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:Web OUT"
    log_label             = "TF-HZN:Web OUT"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [
                              resource.nsxt_policy_group.horizon-db.path,
                              resource.nsxt_policy_group.horizon-rds.path,
                              resource.nsxt_policy_group.horizon-connection.path,
                              resource.nsxt_policy_group.horizon-site-connect.path,
                              resource.nsxt_policy_group.horizon-gateway.path,
                              resource.nsxt_policy_group.horizon-license.path,
                              resource.nsxt_policy_group.horizon-appvol.path
                            ]
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
  rule {
    display_name          = "TF-HZN:Connect-vCenter"
    log_label             = "TF-HZN:Connect-vCenter"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [
                              resource.nsxt_policy_group.horizon-connection.path,
                              resource.nsxt_policy_group.horizon-site-connect.path
                            ]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.https.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:Client-Connection"
    log_label             = "TF-HZN:Client-Connection"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-connection.path]
    destinations_excluded = false
    services              = [
                              resource.nsxt_policy_service.blast-outside.path,
                              data.nsxt_policy_service.vm-pvoip-udp.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.vm-pvoip.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-HZN:Client-Desktop"
    log_label             = "TF-HZN:Client-Desktop"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [
                              resource.nsxt_policy_group.horizon-desktop.path,
                              resource.nsxt_policy_group.horizon-rds.path
                            ]
    destinations_excluded = false
    services              = [
                              resource.nsxt_policy_service.horizon-internal.path,
                              resource.nsxt_policy_service.blast-inside.path,
                              data.nsxt_policy_service.vm-pvoip-udp.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.vm-pvoip.path,
                              data.nsxt_policy_service.rdp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
    rule {
    display_name          = "TF-HZN:LB-AppVol"
    log_label             = "TF-HZN:LB-AppVol"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = ["10.2.16.73"]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-desktop.path]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.https.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
     rule {
    display_name          = "TF-HZN:AppVol-vSphere"
    log_label             = "TF-HZN:AppVol-vSphere"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-appvol.path]
    sources_excluded      = false
    destination_groups    = [
                              resource.nsxt_policy_group.esxi.path,
                              resource.nsxt_policy_group.vcenter.path
                            ]
    destinations_excluded = false
    services              = [data.nsxt_policy_service.https.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
       rule {
    display_name          = "TF-HZN:CloudConn-Public"
    log_label             = "TF-HZN:CloudConn-Public"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-appvol.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [data.nsxt_policy_context_profile.horizon-cloud.path]
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
# Application rules
resource "nsxt_policy_security_policy" "app" {
  display_name    = "TF-Horizon"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 7

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-A-HZN:Cloud-Conn"
    log_label             = "TF-A-HZN:Cloud-Conn"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-site-connect.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-connection.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                            data.nsxt_policy_service.https.path,
                            resource.nsxt_policy_service.cloudconnector.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-HZN:Desktop-CloudConnector"
    log_label             = "TF-A-HZN:Desktop-CloudConnector"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-desktop.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-site-connect.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.desktop-cloudconnector.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-HZN:Desktop-Conn"
    log_label             = "TF-A-HZN:Desktop-Conn"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-desktop.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-connection.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ldap.path,
                              resource.nsxt_policy_service.desktop-connector.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-HZN:Conn-Desktop"
    log_label             = "TF-A-HZN:Conn-Desktop"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-connection.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-desktop.path]
    destinations_excluded = false
    profiles              = []
    services              = [resource.nsxt_policy_service.uag-rds.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-HZN:UAG-Conn"
    log_label             = "TF-A-HZN:UAG-Conn"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.horizon-gateway.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.horizon-connection.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.https.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-HZN:Horizon-Catch"
    log_label             = "TF-A-HZN:Horizon-Catch"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-horizon.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-horizon.path]
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
}
