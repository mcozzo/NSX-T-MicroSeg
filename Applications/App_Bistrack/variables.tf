#===============================================================================
# User credentials
#===============================================================================

# Set in ../secret.auto.tfvars
variable "admin_username" {
  default = "svc-FirstLast@domain.com"
  sensitive   = true
}
variable "admin_password" {
  default = "xxxxxxxxxxxxxxxxxxxxxxx"
  sensitive   = true
}
#variable "aws_key" {
#  default = "xxxxxxxxxxxxxxxxxxxxxxx"
#}
#variable "aws_secret" {
#  default = "xxxxxxxxxxxxxxxxxxxxxxx"
#}

#===============================================================================
# Environment settings
#===============================================================================

variable "nsxt_host" { default = "10.0.0.10"}
variable "nsxt_domain" { default = "cgw" } #This domain must already exist. For VMware Cloud on AWS use cgw
#https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group

variable "nsxt_rules_disabled" { default = true }
variable "nsxt_enable_logging" { default = true }

#===============================================================================
# File Print server variables
#===============================================================================

variable "app_fileprint_servers" { default = [""] }
