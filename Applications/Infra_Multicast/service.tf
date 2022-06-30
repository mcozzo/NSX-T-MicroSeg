# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "TF-UPnP" {
  description  = "UPnP. https://en.wikipedia.org/wiki/Universal_Plug_and_Play Provisioned by Terraform"
  display_name = "TF-UPnP"
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
    display_name      = "TF-UPnP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1900"]
  }
}

resource "nsxt_policy_service" "TF-mDNS" {
  description  = "Multicast DNS. https://en.wikipedia.org/wiki/Multicast_DNS Provisioned by Terraform"
  display_name = "TF-mDNS"
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
    display_name      = "TF-mDNS"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["5353"]
  }
}

resource "nsxt_policy_service" "TF-LLMNR" {
  description  = "Link-Local Multicast Name Resolution. https://en.wikipedia.org/wiki/Link-Local_Multicast_Name_Resolution Provisioned by Terraform"
  display_name = "TF-LLMNR"
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
    display_name      = "TF-LLMNR"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["5355"]
  }
}
