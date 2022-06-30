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

#data "nsxt_policy_vm" "vm-name" {
#  display_name = "vm-name"
#}

#===============================================================================
# Define groups
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group
#===============================================================================

resource "nsxt_policy_group" "aw-scanner" {
  display_name = "TF-App-ArcticWolf"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = ["10.2.30.96", "10.2.30.97"]
    }
  }
}
resource "nsxt_policy_group" "aw-public-ip" {
  display_name = "TF-App-ArcticWolf-PublicIP"
  description  = "Terraform provisioned Group"
  domain       = var.nsxt_domain

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [
        "44.239.235.232-44.239.235.239",
        "44.234.73.124-44.234.73.127",
        "52.27.156.227-52.27.160.160",
        "35.84.197.208-35.84.197.228",
        "3.235.189.104-3.235.189.111",
        "44.234.73.208-44.234.73.215",
        "3.15.167.216-3.15.167.223"
      ]
    }
  }
}
