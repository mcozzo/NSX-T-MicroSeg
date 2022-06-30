#===============================================================================
# Identify pre defined objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_group
#===============================================================================

data "nsxt_policy_group" "rfc1918" {
  display_name = "RFC1918"
}
data "nsxt_policy_group" "arcticwolf" {
  display_name = "TF-App-ArcticWolf"
}

#===============================================================================
# VM objects
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_vm
#===============================================================================

data "nsxt_policy_vm" "cprime" {
  display_name = "DC-CPrime-01"
}
data "nsxt_policy_vm" "vrli" {
  display_name = "VMware-vRealize-Log-Insight"
}
data "nsxt_policy_vm" "prtg16-01" {
  display_name = "DC-PRTGW16-01"
}
data "nsxt_policy_vm" "prtg19-01" {
  display_name = "DC-PRTGW19-01"
}
data "nsxt_policy_vm" "prtg19-02" {
  display_name = "DC-PRTGW19-02"
}
data "nsxt_policy_vm" "dngdmz" {
  display_name = "DC-DNGDMZ-01"
}




#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "syslog" {
  display_name = "TF-App-Syslog"
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
      value       = "log-server|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    path_expression {
      member_paths = [data.nsxt_policy_group.arcticwolf.path]
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    external_id_expression {
      member_type  = "VirtualMachine"
      external_ids = [
        data.nsxt_policy_vm.cprime.id,
        data.nsxt_policy_vm.vrli.id
      ]
    }
  }
}
resource "nsxt_policy_group" "snmp" {
  display_name = "TF-App-SNMP"
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
      value       = "snmp|service"
    }
  }
}
resource "nsxt_policy_group" "dng" {
  display_name = "TF-App-DNG"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    external_id_expression {
      member_type  = "VirtualMachine"
      external_ids = [
        data.nsxt_policy_vm.prtg16-01.id,
        data.nsxt_policy_vm.prtg19-01.id,
        data.nsxt_policy_vm.prtg19-02.id,
        data.nsxt_policy_vm.dngdmz.id
      ]
    }
  }
}
resource "nsxt_policy_group" "prtg" {
  display_name = "TF-App-PRTG"
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
      value       = "prtg|app"
    }
  }

  conjunction {
    operator = "OR"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.30.215","10.250.1.10","10.2.30.115"]
    }
  }
}
