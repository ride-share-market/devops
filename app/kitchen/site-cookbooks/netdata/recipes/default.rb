#
# Cookbook Name:: netdata
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
package "zlib1g-dev"
package "make"

remote_file node["netdata"]["options"]["filename"] do
  action :create_if_missing
  source node["netdata"]["options"]["source"]
  retries 5
  retry_delay 3
end

bash 'Extract Netdata Archive' do
  cwd "/opt"
  code <<-EOH
    tar xzf "#{node["netdata"]["options"]["filename"]}"
  EOH
  not_if { ::File.exists?(node["netdata"]["options"]["path"]) }
end

template "/etc/init/netdata.conf" do
  source "upstart_netdata.conf.erb"
  variables({
                :options => node["netdata"]["options"]
            })
end

service "netdata" do
  action [:enable, :start]
end
