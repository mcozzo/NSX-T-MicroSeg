# Var file for VMC

#===============================================================================
# User credentials
#===============================================================================

# Set user variables in secret.auto.tfvars

#===============================================================================
# Environment settings
#===============================================================================

nsxt_host = "10.0.0.10"
nsxt_domain = "default" #https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_group

nsxt_rules_disabled = true
nsxt_enable_logging = true

#===============================================================================
# File Print server variables
#===============================================================================

app_fileprint_servers = ["10.1.2.3"]
