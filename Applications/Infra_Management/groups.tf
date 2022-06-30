#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}

#===============================================================================
# VM objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_vm
#===============================================================================

data "nsxt_policy_vm" "dc-mgmtw16-01" {
  display_name = "DC-MGMTW16-01"
}

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "rdp_gateway" {
  display_name = "TF-App-RemoteDesktopGateway"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.15.136"]
    }
  }
}
resource "nsxt_policy_group" "rdp_management" {
  display_name = "TF-App-RemoteMGMT"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.15.101"]
    }
  }
}
resource "nsxt_policy_group" "app-adaxes" {
  display_name = "TF-App-Adaxes"
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
      value       = "adaxes|app"
    }
  }
}
resource "nsxt_policy_group" "mgmt-devices" {
  display_name = "TF-MGMT-Devices"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.152.2.0/24", "10.10.24.0/24", "10.1.15.101", "10.2.15.101"]
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    external_id_expression {
      member_type  = "VirtualMachine"
      external_ids = [data.nsxt_policy_vm.dc-mgmtw16-01.id]
    }
  }
}
resource "nsxt_policy_group" "app_management" {
  display_name = "TF-App-Management"
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
      value       = "management|app"
    }
  }
}
