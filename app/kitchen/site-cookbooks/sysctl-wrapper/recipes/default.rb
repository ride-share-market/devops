#
# Cookbook Name:: sysctl-wrapper
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "sysctl::default"

sysctl_param "net.ipv4.ip_forward" do
  value 1
end
