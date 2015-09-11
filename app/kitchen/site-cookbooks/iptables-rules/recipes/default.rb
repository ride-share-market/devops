#
# Cookbook Name:: iptables-rules
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables::default"

iptables_rule "nat_forward" do
  action :enable
end

iptables_rule "nat_masquerade" do
  action :enable
end
