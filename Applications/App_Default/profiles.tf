#===============================================================================
# Context profiles
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_context_profile
# https://registry.terraform.io/providers/vmware/nsxt/latest/docs/data-sources/policy_context_profile
#===============================================================================

#data "nsxt_policy_context_profile" "dns" {
#  display_name = "DNS"
#}

data "nsxt_policy_context_profile" "http" {
  display_name = "HTTP"
}
data "nsxt_policy_context_profile" "http2" {
  display_name = "HTTP2"
}
