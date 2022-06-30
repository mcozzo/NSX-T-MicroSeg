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
data "nsxt_policy_service" "mssqls" {
  display_name = "MS-SQL-S"
}
data "nsxt_policy_service" "sharepoint2010v1" {
  display_name = "SharePoint 2010 V1"
}
data "nsxt_policy_service" "msreplication" {
  display_name = "MS Replication service"
}
#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "sp-printing" {
  description  = "Sharepoint Printing . Provisioned by Terraform"
  display_name = "TF-SP:Printing"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-SP:Printing"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["3910"]
 }

}
resource "nsxt_policy_service" "sp-webservices" {
  description  = "Sharepoint Web to app services . Provisioned by Terraform"
  display_name = "TF-SP:web-app-services"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-SP:web-app-out"
    description       = ""
    protocol          = "TCP"
    source_ports      = []  
    destination_ports = ["22233-22236","1027","12290","808","22233"]
 }
   l4_port_set_entry {
    display_name      = "TF-SP:web-app-in"
    description       = ""
    protocol          = "TCP"
    source_ports      = ["16500-16519","22233-22236"]  
    destination_ports = []
  }
}
resource "nsxt_policy_service" "sp-app-web" {
  description  = "Sharepoint app to web services . Provisioned by Terraform"
  display_name = "TF-SP:app-web-services"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-SP:app-web-services"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["22233"]
 }
}