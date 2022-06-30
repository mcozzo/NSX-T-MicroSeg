# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "ftp_passive" {
  description  = "Crush FTP service provisioned by Terraform"
  display_name = "TF-FTP-Passive"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  #l4_port_set_entry {
  #  display_name      = "FTP"
  #  description       = "FTP Port 21"
  #  protocol          = "TCP"
  #  destination_ports = ["21"]
  #}

  l4_port_set_entry {
    display_name      = "FTP-Passive"
    description       = "FTP Port 1025-65535"
    protocol          = "TCP"
    destination_ports = ["1025-65535"]
  }
}

resource "nsxt_policy_service" "ftp_proxy" {
  description  = "Crush FTP service provisioned by Terraform"
  display_name = "TF-FTP-Proxy"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "FTP-Passive"
    description       = "FTP Port 9000"
    protocol          = "TCP"
    destination_ports = ["9000"]
  }
}

# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service

data "nsxt_policy_service" "ftp" {
  display_name = "FTP"
}

data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}
