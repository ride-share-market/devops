#
# Cookbook Name:: iptables-rules
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables::default"

include_recipe "iptables-rules::lan_nat"

include_recipe "iptables-rules::vpn_lan_nat"

include_recipe "iptables-rules::forwarding"

# include_recipe "iptables-rules::dnat_ssh"
