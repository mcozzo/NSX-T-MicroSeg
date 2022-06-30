#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "policy1" {
  display_name    = "TF-SecretServer"
  description     = "Terraform provisioned Security Policy"
  category        = "Infrastructure"
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
    display_name          = "TF-SS:WebAccess"
    log_label             = "TF-SS:WebAccess"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.secret-server.path]
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
    display_name          = "TF-SS:Inbound"
    log_label             = "TF-SS:Inbound"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.secret-server.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ms-ad.path,
                              data.nsxt_policy_service.ms-ad-udp.path,
                              data.nsxt_policy_service.kerberos-tcp.path,
                              data.nsxt_policy_service.kerberos-udp.path,
                              data.nsxt_policy_service.ldap.path,
                              data.nsxt_policy_service.ldap-s.path,
                              data.nsxt_policy_service.ldap-s-udp.path,
                              data.nsxt_policy_service.ldap-udp.path,
                              data.nsxt_policy_service.ms-sql-s.path,
                              data.nsxt_policy_service.ms-rpc.path,
                              data.nsxt_policy_service.netbios-nameservice-udp.path,
                              data.nsxt_policy_service.netbios-session-tcp.path,
                              data.nsxt_policy_service.oracle.path,
                              data.nsxt_policy_service.smb.path,
                              data.nsxt_policy_service.smb-udp.path,
                              data.nsxt_policy_service.ssh.path,
                              data.nsxt_policy_service.telnet.path,
                              data.nsxt_policy_service.win2008.path,
                              resource.nsxt_policy_service.secret-server.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-SS:Inbound"
    log_label             = "TF-SS:Inbound"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.secret-server.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.rfc1918.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.ms-ad.path,
                              data.nsxt_policy_service.ms-ad-udp.path,
                              data.nsxt_policy_service.kerberos-tcp.path,
                              data.nsxt_policy_service.kerberos-udp.path,
                              data.nsxt_policy_service.ldap.path,
                              data.nsxt_policy_service.ldap-s.path,
                              data.nsxt_policy_service.ldap-s-udp.path,
                              data.nsxt_policy_service.ldap-udp.path,
                              data.nsxt_policy_service.ms-sql-s.path,
                              data.nsxt_policy_service.ms-rpc.path,
                              data.nsxt_policy_service.netbios-nameservice-udp.path,
                              data.nsxt_policy_service.netbios-session-tcp.path,
                              data.nsxt_policy_service.oracle.path,
                              data.nsxt_policy_service.smb.path,
                              data.nsxt_policy_service.smb-udp.path,
                              data.nsxt_policy_service.ssh.path,
                              data.nsxt_policy_service.telnet.path,
                              data.nsxt_policy_service.win2008.path,
                              resource.nsxt_policy_service.secret-server.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
}
