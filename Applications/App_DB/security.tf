#===============================================================================
# The actual firewall rules
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_security_policy#sources_excluded
#===============================================================================

# Infrastructure rules
resource "nsxt_policy_security_policy" "env" {
  display_name    = "TF-Database"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  category        = "Environment"
  #category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 10

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-DB:InterDB"
    log_label             = "TF-DB:InterDB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.tier-db.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.tier-db.path]
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
    display_name          = "TF-DB:Protect"
    log_label             = "TF-DB:Protect"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [data.nsxt_policy_group.rfc1918.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.tier-db.path]
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

resource "nsxt_policy_security_policy" "app" {
  display_name    = "TF-DB"
  description     = "Terraform provisioned Security Policy"
  #category        = "Infrastructure"
  #category        = "Environment"
  category        = "Application"
  domain          = var.nsxt_domain
  locked          = false
  stateful        = true
  tcp_strict      = false
  sequence_number = 10

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  rule {
    display_name          = "TF-A-DB:InterDB"
    log_label             = "TF-A-DB:InterDB"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.tier-db.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.tier-db.path]
    destinations_excluded = false
    profiles              = []
    services              = [
                            data.nsxt_policy_service.mssql.path,
                            data.nsxt_policy_service.mssqls.path,
                            data.nsxt_policy_service.mssqlsde.path
                            ]
    action                = "ALLOW"
    disabled              = var.nsxt_rules_disabled

    tag {
        scope = "managed-by"
        tag   = "terraform"
    }
  }
  rule {
    display_name          = "TF-A-DB:InterDB_Catch"
    log_label             = "TF-A-DB:InterDB_Catch"
    notes                 = ""
    logged                = var.nsxt_enable_logging

    source_groups         = [resource.nsxt_policy_group.tier-db.path]
    sources_excluded      = false
    destination_groups    = [resource.nsxt_policy_group.tier-db.path]
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
