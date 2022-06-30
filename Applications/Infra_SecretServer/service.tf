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
data "nsxt_policy_service" "ms-ad" {
  display_name = "Active Directory Server"
}
data "nsxt_policy_service" "ms-ad-udp" {
  display_name = "Active Directory Server UDP"
}
data "nsxt_policy_service" "kerberos-tcp" {
  display_name = "KERBEROS-TCP"
}
data "nsxt_policy_service" "kerberos-udp" {
  display_name = "KERBEROS-UDP"
}
data "nsxt_policy_service" "ldap" {
  display_name = "LDAP"
}
data "nsxt_policy_service" "ldap-s" {
  display_name = "LDAP-over-SSL"
}
data "nsxt_policy_service" "ldap-s-udp" {
  display_name = "LDAP-over-SSL-UDP"
}
data "nsxt_policy_service" "ldap-udp" {
  display_name = "LDAP-UDP"
}
data "nsxt_policy_service" "ms-sql-s" {
  display_name = "MS-SQL-S"
}
data "nsxt_policy_service" "ms-rpc" {
  display_name = "MS_RPC_TCP"
}
data "nsxt_policy_service" "netbios-nameservice-udp" {
  display_name = "NetBios Name Service (UDP)"
}
data "nsxt_policy_service" "netbios-session-tcp" {
  display_name = "NetBios Session Service (TCP)"
}
data "nsxt_policy_service" "oracle" {
  display_name = "Oracle"
}
data "nsxt_policy_service" "smb" {
  display_name = "SMB"
}
data "nsxt_policy_service" "smb-udp" {
  display_name = "SMB Server UDP"
}
data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}
data "nsxt_policy_service" "telnet" {
  display_name = "TELNET"
}
data "nsxt_policy_service" "win2008" {
  display_name = "Win 2008 - RPC, DCOM, EPM, DRSUAPI, NetLogonR, SamR, FRS"
}

#===============================================================================
# The services used if not pre defined
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_service
#===============================================================================

resource "nsxt_policy_service" "secret-server" {
  description  = "A Service. Provisioned by Terraform"
  display_name = "TF-Secret-Server"
  tag {
      scope = "managed-by"
      tag   = "terraform"
  }

  l4_port_set_entry {
    display_name      = "TF-SecretServer-TCP"
    description       = ""
    protocol          = "TCP"
    destination_ports = ["135","2638"]
  }

  l4_port_set_entry {
    display_name      = "TF-SecretServer-UDP"
    description       = ""
    protocol          = "UDP"
    destination_ports = ["1434","5000","49152-65535"]
  }
}
