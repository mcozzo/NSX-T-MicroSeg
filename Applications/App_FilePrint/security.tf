#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "environment" {
  display_name    = "TF-FilePrint"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
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
    display_name          = "TF-FilePrint:Clinet-IN"
    log_label             = "TF-FilePrint:Clinet-IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.fileprint.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              data.nsxt_policy_service.http.path,
                              data.nsxt_policy_service.https.path,
                              data.nsxt_policy_service.ms-ds-tcp.path,
                              data.nsxt_policy_service.ms-ds-udp.path,
                              data.nsxt_policy_service.ms-rpc-tcp.path,
                              data.nsxt_policy_service.ms-rpc-udp.path,
                              data.nsxt_policy_service.netbios-nameservice-tcp.path,
                              data.nsxt_policy_service.netbios-nameservice-udp.path,
                              data.nsxt_policy_service.netbios-session-tcp.path,
                              data.nsxt_policy_service.netbios-session-udp.path,
                              resource.nsxt_policy_service.fileprint.path,
                              resource.nsxt_policy_service.dfsn.path
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
    display_name          = "TF-FilePrint:InterApp"
    log_label             = "TF-FilePrint:InterApp"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.fileprint.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.fileprint.path]
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
    display_name          = "TF-FilePrint:Clinet-IN"
    log_label             = "TF-FilePrint:Clinet-IN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.fileprint.path]
    sources_excluded      = false
    destination_groups    = [data.nsxt_policy_group.btprinters.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.btprinters.path
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
resource "nsxt_policy_security_policy" "application" {
  display_name    = "TF-FilePrint"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
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
    display_name          = "TF-FilePrint:DFSN"
    log_label             = "TF-FilePrint:DFSN"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.fileprint.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.fileprint.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                              resource.nsxt_policy_service.dfsn.path
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
