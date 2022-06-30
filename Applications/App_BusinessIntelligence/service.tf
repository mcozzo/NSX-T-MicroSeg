#===============================================================================
# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service
#===============================================================================

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "mssql" {
  display_name = "Microsoft SQL Server"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "amqp" {
  description  = "BI AMQP. Provisioned by Terraform"
  display_name = "TF-BI-AMQP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BI-AMQP-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["5671-5672","9350-9354"]
  }
}
resource "nsxt_policy_service" "bi_mgmt" {
  description  = "BI Management. Provisioned by Terraform"
  display_name = "TF-BI-MGMT"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BI-MGMT-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["4780"]
  }
}
resource "nsxt_policy_service" "bi_db" {
  description  = "BI DB. Provisioned by Terraform"
  display_name = "TF-BI-DB"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BI-DB-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8603"]
  }
}
