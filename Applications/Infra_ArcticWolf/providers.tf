#===============================================================================
# Versioning
#===============================================================================

terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = "3.2.7"
    }
  }
}

#===============================================================================
# Provider Base Configuration
#===============================================================================

provider "nsxt" {
  host                     = var.nsxt_host
  username                 = var.admin_username
  password                 = var.admin_password
  allow_unverified_ssl     = true
  max_retries              = 25
  retry_min_delay          = 500
  retry_max_delay          = 20000
  retry_on_status_codes    = [429]
}
