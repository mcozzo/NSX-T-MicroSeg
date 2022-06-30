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
data "nsxt_policy_service" "ftp" {
  display_name = "FTP"
}
data "nsxt_policy_service" "mssql" {
  display_name = "Microsoft SQL Server"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "bistrack-cc" {
  description  = "BisTrack CC processing. Provisioned by Terraform"
  display_name = "TF-BisTrack-CC"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BisTrack-CC-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["9876"]
  }
}
resource "nsxt_policy_service" "bistrack-scangun" {
  description  = "BisTrack ScanGuns. Provisioned by Terraform"
  display_name = "TF-BisTrack-ScanGun"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BisTrack-ScanGun-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["5401","8843"]
  }
}
resource "nsxt_policy_service" "ftp-pasv" {
  description  = "Bistrack Passive FTP provisioned by Terraform"
  display_name = "TF-BisTrack-FTP-Passive"

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "FTP-Passive"
    description       = "FTP Port 1025-65535"
    protocol          = "TCP"
    destination_ports = ["1025-65535"]
  }
}
resource "nsxt_policy_service" "rti" {
  description  = "Bistrack RTI Service provisioned by Terraform"
  display_name = "TF-BisTrack-RTI"

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BisTrack-RTI"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["8703"]
  }
}
resource "nsxt_policy_service" "dynamics" {
  description  = "Bistrack GP Dynamics Service provisioned by Terraform"
  display_name = "TF-BisTrack-dynamics"

  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-BisTrack-dynamics-tcp"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["1433"]
  }
  l4_port_set_entry {
    display_name      = "TF-BisTrack-dynamics-udp"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1434"]
  }
}
