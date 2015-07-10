#
# Cookbook Name:: docker-containers-prd
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

  # Find logstash machine, for now it's only one: log01
  is_logstash_node = host["roles"].select { |r| r[/^log/] }
  if is_logstash_node.size > 0
    node.default["hosts"][:logstash_ip] = host["digitalOcean"]["ip"]["eth1"]
  end

  # Find metrics machine, for now it's only one: met01
  is_metrics_node = host["roles"].select { |r| r[/^met/] }
  if is_metrics_node.size > 0
    node.default["hosts"][:metrics_ip] = host["digitalOcean"]["ip"]["eth1"]
  end

  # Find rabbitmq machine, for now it's only one: rmq01
  is_rabbitmq_node = host["roles"].select { |r| r[/^rmq/] }
  if is_rabbitmq_node.size > 0
    node.default["hosts"][:rabbitmq_ip] = host["digitalOcean"]["ip"]["eth1"]
  end

  # Find mongodb machine, for now it's only one: mgo01
  is_mongodb_node = host["roles"].select { |r| r[/^mgo/] }
  if is_mongodb_node.size > 0
    node.default["hosts"][:mongodb_ip] = host["digitalOcean"]["ip"]["eth1"]
  end
  
}

include_recipe "docker-containers::default"
