# The ordering below is important.
# Some networks will have the same sub-domain names, eg: registry.ridesharemarket.com
# The network that comes last will overwrite any previous hostname entries.
# For example below registry.ridesharemarket.com will first be set to dev.ams then updated to dev.vbx.
# The default for this cookbook is the vbx env, we want registry.ridesharemarket.com to point to local not remote.
default["network-hosts"] = [
    "dev_vbx_ridesharemarket",
    "prd_ams_ridesharemarket"
]
