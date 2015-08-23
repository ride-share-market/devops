#
# Cookbook Name:: docker-wrapper
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
# Needed linux-image-extra for aufs filesystem support
package "linux-image-extra-`uname -r`"

docker_service "default" do
  version "1.7.1"
  action [:create, :start]
  insecure_registry node["docker-wrapper"]["docker_opts"]["insecure-registry"]
end

include_recipe "docker-wrapper::docker-upstart"
