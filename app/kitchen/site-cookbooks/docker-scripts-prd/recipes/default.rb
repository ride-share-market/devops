#
# Cookbook Name:: docker-scripts-prd
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
prd_hosts = data_bag_item("network", "prd_aws_ridesharemarket")

prd_hosts["hosts"].each { |host|

  next if !IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]

  # Find docker_private_registry machine, for now it's only one: reg01
  is_docker_registry_node = host["roles"].select { |r| r[/^reg/] }
  if is_docker_registry_node.size > 0
    node.default["hosts"][:docker_registry_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

  # Find logstash machine, for now it's only one: log01
  is_logstash_node = host["roles"].select { |r| r[/^log/] }
  if is_logstash_node.size > 0
    node.default["hosts"][:logstash_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

  # Find metrics machine, for now it's only one: met01
  is_metrics_node = host["roles"].select { |r| r[/^met/] }
  if is_metrics_node.size > 0
    node.default["hosts"][:metrics_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

  # Find rabbitmq machine, for now it's only one: rmq01
  is_rabbitmq_node = host["roles"].select { |r| r[/^rmq/] }
  if is_rabbitmq_node.size > 0
    node.default["hosts"][:rabbitmq_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

  # Find mongodb machine, for now it's only one: mgo01
  is_mongodb_node = host["roles"].select { |r| r[/^mgo/] }
  if is_mongodb_node.size > 0
    node.default["hosts"][:mongodb_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

  # Find couchbase machine, for now it's only one: cch01
  is_couchbase_node = host["roles"].select { |r| r[/^cch/] }
  if is_couchbase_node.size > 0
    node.default["hosts"][:couchbase_ip] = host["cloud"]["ip"]["eni"]["eth0"]
  end

}
