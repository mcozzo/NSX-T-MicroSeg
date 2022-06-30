
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded

# Infrastructure rules
resource "nsxt_policy_security_policy" "internal" {
  display_name    = "TF-Services-Internal"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
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
    display_name          = "TF-SVC:ICMP-Public"
    log_label             = "TF-SVC:ICMP-Public"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [data.nsxt_policy_service.icmpall.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:ICMP-Inside"
    log_label             = "TF-SVC:ICMP-Inside"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [data.nsxt_policy_service.icmpall.path]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:DNS-L7"
    log_label             = "TF-SVC:DNS-L7"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-dns.path]
    destinations_excluded = false
    profiles              = [data.nsxt_policy_context_profile.dns.path]
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              resource.nsxt_policy_service.TF-dns-tls.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:DNS"
    log_label             = "TF-SVC:DNS"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-dns.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path,
                              resource.nsxt_policy_service.TF-dns-tls.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:DNS-Umbrella"
    log_label             = "TF-SVC:DNS-Umbrella"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-dns.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-dns.path]
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
    display_name          = "TF-SVC:NTP"
    log_label             = "TF-SVC:NTP"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-ntp.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ntp.path,
                              data.nsxt_policy_service.ntp-ts.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:DHCP-Relay"
    log_label             = "TF-SVC:NTP"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = []
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-dhcp.path, "255.255.255.255/32"]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dhcp-server.path,
                              data.nsxt_policy_service.dhcpv6-server.path,
                              resource.nsxt_policy_service.dhcp-failover.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:DHCP-Reply"
    log_label             = "TF-SVC:NTP"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.app-dhcp.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path, "255.255.255.255/32"]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dhcp-client.path,
                              data.nsxt_policy_service.dhcpv6-client.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:NetBios"
    log_label             = "TF-SVC:NetBios"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.netbios-datagram-tcp.path,
                              data.nsxt_policy_service.netbios-datagram-udp.path,
                              data.nsxt_policy_service.netbios-nameservice-tcp.path,
                              data.nsxt_policy_service.netbios-nameservice-udp.path,
                              data.nsxt_policy_service.netbios-session-tcp.path,
                              data.nsxt_policy_service.netbios-session-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:SMB"
    log_label             = "TF-SVC:SMB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ms-ds-tcp.path,
                              data.nsxt_policy_service.ms-ds-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:ADFS"
    log_label             = "TF-SVC:ADFS"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-adfs.path]
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
    display_name          = "TF-SVC:RPC"
    log_label             = "TF-SVC:RPC"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ms-rpc-tcp.path,
                              data.nsxt_policy_service.ms-rpc-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:AD"
    log_label             = "TF-SVC:AD"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-activedirectory.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ms-ad-v1.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC:WebAuth"
    log_label             = "TF-SVC:WebAuth"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.app-webauth.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              resource.nsxt_policy_service.webauth.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}

resource "nsxt_policy_security_policy" "external" {
  display_name    = "TF-Services-External"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
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
    display_name          = "TF-SVC-OUT:DNS"
    log_label             = "TF-SVC-OUT:DNS"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [
                              resource.nsxt_policy_group.app-activedirectory.path,
                              resource.nsxt_policy_group.app-dns.path
                            ]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SVC-OUT:NTP"
    log_label             = "TF-SVC-OUT:NTP"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [
                              resource.nsxt_policy_group.app-activedirectory.path,
                              resource.nsxt_policy_group.app-ntp.path
                            ]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [ data.nsxt_policy_service.ntp.path ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-DEL-SVC-OUT:DNS-L7"
    log_label             = "TF-DEL-SVC-OUT:DNS-L7"
    notes                 = "This rule should be deleted. Currently servers / clients etc are able to query public DNS servers. That should be only allowed to internal servers. Only a specific set of internal servers should then be allowed out."
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = [data.nsxt_policy_context_profile.dns.path]
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-DEL-SVC-OUT:DNS"
    log_label             = "TF-DEL-SVC-OUT:DNS"
    notes                 = "This rule should be deleted. Currently servers / clients etc are able to query public DNS servers. That should be only allowed to internal servers. Only a specific set of internal servers should then be allowed out."
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.dns.path,
                              data.nsxt_policy_service.dns-udp.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-DEL-SVC-OUT:NTP"
    log_label             = "TF-DEL-SVC-OUT:NTP"
    notes                 = "This rule should be deleted. Currently servers / clients etc are able to query public NTP servers. That should be only allowed to internal servers. Only a specific set of internal servers should then be allowed out."
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = true
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ntp.path,
                              data.nsxt_policy_service.ntp-ts.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
