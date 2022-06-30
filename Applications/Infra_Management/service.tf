# Pre defined services
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_service

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}
data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}
data "nsxt_policy_service" "rdp" {
  display_name = "RDP"
}
data "nsxt_policy_service" "ms-ad-v1" {
  display_name = "Microsoft Active Directory V1"
}
data "nsxt_policy_service" "dns" {
  display_name = "DNS"
}
data "nsxt_policy_service" "dns-udp" {
  display_name = "DNS-UDP"
}
data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}

# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service

resource "nsxt_policy_service" "rdp-udp" {
  description  = "RDP UDP. Because there was some UDP traffic. Provisioned by Terraform"
  display_name = "TF-RDP-UDP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-RDP-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["3389","3391"]
  }
}
resource "nsxt_policy_service" "adaxes" {
  description  = "Adaxes client managment connection. Because there was some UDP traffic. Provisioned by Terraform"
  display_name = "TF-Adaxes"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-Adaxes"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["54782"]
  }
}
resource "nsxt_policy_service" "win-rm" {
  description  = "https://docs.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management Provisioned by Terraform"
  display_name = "TF-Windows Remote Management"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-WinRM"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["5985","5986"]
  }
}
resource "nsxt_policy_service" "mgmt-ports" {
  description  = "Provisioned by Terraform"
  display_name = "TF-MGMT Ports"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-MGMT"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8443","9443","8080","10000"]
  }
}
resource "nsxt_policy_service" "https-udp" {
  description  = "Provisioned by Terraform"
  display_name = "TF-HTTPS UDP"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-HTTPS UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["443"]
  }
}
