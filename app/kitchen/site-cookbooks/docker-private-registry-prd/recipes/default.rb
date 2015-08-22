#
# Cookbook Name:: docker-private-registry-prd
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
prd_hosts = data_bag_item("network", "prd_ams_ridesharemarket")

prd_hosts["hosts"].each { |host|

  next if !IPAddress.valid? host["digitalOcean"]["ip"]["eth1"]

  # Find docker_private_registry machine, for now it's only one: reg01
  is_docker_registry_node = host["roles"].select { |r| r[/^reg/] }
  if is_docker_registry_node.size > 0
    node.default["hosts"][:docker_registry_ip] = host["digitalOcean"]["ip"]["eth1"]
  end

}

include_recipe "docker-private-registry::default"
