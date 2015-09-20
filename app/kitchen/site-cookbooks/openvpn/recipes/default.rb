#
# Cookbook Name:: openvpn
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "secrets::default"

raise "Missing required openvpn secrets." if !node[:secrets][:data][:openvpn]

package "openvpn"

service "openvpn" do
  supports :restart => true, :reload => true
  action :nothing
end

template "/etc/default/openvpn" do
  source "openvpn.erb"
  variables({
                :fragment_max => node["openvpn"]["fragment_max"]
            })
  notifies :restart, "service[openvpn]"
end

template "/etc/openvpn/server.conf" do
  source "server.conf.erb"
  notifies :restart, "service[openvpn]"
end

file "/etc/openvpn/ca.crt" do
  content node[:secrets][:data][:openvpn][:ca_crt]
  notifies :restart, "service[openvpn]"
end

file "/etc/openvpn/dh2048.pem" do
  content node[:secrets][:data][:openvpn][:dh2048_pem]
  notifies :restart, "service[openvpn]"
end

file "/etc/openvpn/server.crt" do
  content node[:secrets][:data][:openvpn][:server_crt]
  notifies :restart, "service[openvpn]"
end

file "/etc/openvpn/server.key" do
  content node[:secrets][:data][:openvpn][:server_key]
  mode "0600"
  notifies :restart, "service[openvpn]"
end
