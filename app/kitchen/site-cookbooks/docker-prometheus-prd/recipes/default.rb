#
# Cookbook Name:: docker-prometheus-prd
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
# all valid IPs
hosts = []
metrics_hosts = []

prd_hosts = data_bag_item("network", "prd_aws_ridesharemarket")

prd_hosts["hosts"].each { |host|

  next if !IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]

  # add each node/machine/IP to the node and docker prometheus scrape jobs
  hosts.push host["cloud"]["ip"]["eni"]["eth0"]

  # Find docker_private_registry machine, for now it's only one: reg01

  is_metrics_node = host["roles"].select { |r| r[/^met/] }

  if is_metrics_node.size > 0
    metrics_hosts.push host["cloud"]["ip"]["eni"]["eth0"]
  end

}

node.default["docker-prometheus"]["scrape_configs"] = [
    {
        :job_name => "node",
        :target_groups => hosts
    },
    {
        :job_name => "docker",
        :target_groups => hosts
    },
    {
        :job_name => "statsd",
        :target_groups => metrics_hosts
    }
]

include_recipe "docker-prometheus::default"
