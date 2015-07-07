default[:firehol][:start_firehol] = "YES"

# Virtualbox public interface
default[:firehol][:virtual_box_hosts] = "10.0.0.0/8"

# Virtual Box LAN subnet
default[:firehol][:lan_hosts] = [
    "192.168.33.0/24"
]

# Consul network is all known dev and prd machines
default[:firehol][:network][:consul] = [
    "dev_vbx_ridesharemarket"
]

default[:firehol][:docker][:enable_public_access] = false
