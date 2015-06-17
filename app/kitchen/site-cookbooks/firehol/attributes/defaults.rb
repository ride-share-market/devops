default["firehol"]["start_firehol"] = "YES"

default["firehol"]["network"]["acl"] = "prd_ams_ridesharemarket"

default["firehol"]["virtual_box_hosts"] = nil

# Consul network is all known dev and prd machines
default["firehol"]["network"]["consul"] = [
    "prd_ams_ridesharemarket"
]
