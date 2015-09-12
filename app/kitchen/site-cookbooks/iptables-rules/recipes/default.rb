#
# Cookbook Name:: iptables-rules
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables::default"

include_recipe "iptables-rules::nat_masquerade"

include_recipe "iptables-rules::dnat_ssh"

