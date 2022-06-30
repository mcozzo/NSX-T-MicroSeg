#===============================================================================
# Context profiles
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_context_profile
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_context_profile
#===============================================================================

data "nsxt_policy_context_profile" "arctic-wolf-urls" {
  display_name = "Arctic Wolf URLs"
}

#resource "nsxt_policy_context_profile" "arctic-wolf-urls" {
#  display_name = "TF-ArcticWolf-URLs"
#  description     = "Terraform provisioned Security Policy"
#
#  tag {
#      scope = "managed-by"
#      tag   = "terraform"
#  }
#
#  domain_name {
#    description = "AW-PublicURLs"
#
#    #Works
#    #value       = ["*-myfiles.sharepoint.com"]
#
#    #Does not work
#    value       = ["*.arcticwolf.net","*.rootsoc.com","*.msftconnecttest.com","*.arcticwolf.com"]
#  }
#}
