#===============================================================================
# Identify pre defined objects
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}

#===============================================================================
# Define groups
#===============================================================================

resource "nsxt_policy_group" "app-ftp" {
  display_name = "TF-App-FTP"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "ftp|app"
    }
  }
}

resource "nsxt_policy_group" "app-ftp-external" {
  display_name = "TF-App-External"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "ftp|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "public|tier"
    }
  }
}

resource "nsxt_policy_group" "app-ftp-internal" {
  display_name = "TF-App-Internal"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "ftp|app"
    }
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "internal|tier"
    }
  }
}
