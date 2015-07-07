#
# Cookbook Name:: firehol-prd
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#

# Find all LAN IPs
node.default["firehol"]["lan_hosts"] = []

node["firehol"]["network"]["consul"].each { |network_data|

  network = data_bag_item("network", network_data)

  network["hosts"].each { |host|

    if IPAddress.valid? host["digitalOcean"]["ip"]["eth1"]
      node.default["firehol"]["lan_hosts"].push(host["digitalOcean"]["ip"]["eth1"])
    end

  }

}

include_recipe "firehol::default"
