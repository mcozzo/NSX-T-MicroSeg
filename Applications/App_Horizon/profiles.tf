#===============================================================================
# Context profiles
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_context_profile
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_context_profile
#===============================================================================

data "nsxt_policy_context_profile" "horizon-cloud" {
  display_name = "Horizon Cloud"
}
