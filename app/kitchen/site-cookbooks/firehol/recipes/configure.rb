raise "Missing required portknock sequences" if !node[:secrets][:data][:firehol][:hosts]

# Find all known dev and prd machine public IPs for consul monitoring network
consul_hosts = []

node[:firehol][:network][:consul].each { |network_data|

  network = data_bag_item("network", network_data)

  network["hosts"].each { |host|

    if IPAddress.valid? host["digitalOcean"]["ip"]["eth1"]
      consul_hosts.push(host["digitalOcean"]["ip"]["eth1"])
    end

  }

}

# Customized startup script that restarts docker after firehol stop|start|restart
template "/etc/init.d/firehol" do
  source "etc_init.d_firehol.erb"
  mode 0755
end

template "/etc/default/firehol" do
  source "etc_default_firehol.erb"
  variables({
                :start_firehol => node[:firehol][:start_firehol]
            })
end

template "/etc/firehol/firehol.conf" do
  source "firehol.conf.erb"
  variables({
                :lan_hosts => node[:firehol][:lan_hosts].join(" "),

                :virtual_box_hosts => node[:firehol][:virtual_box_hosts],

                :hosts => node[:secrets][:data][:firehol][:hosts],

                :consul_hosts => consul_hosts.join(" ")
            })
  notifies :restart, "service[firehol]", :immediately
end

template "/home/ubuntu/docker_iptables.sh" do
  source "docker_iptables.sh.erb"
  mode 0755
  owner "ubuntu"
  group "ubuntu"
  variables({
                :lan_hosts => node[:firehol][:lan_hosts],
                :hosts => node[:secrets][:data][:firehol][:hosts],
                :enable_public_access => node[:firehol][:docker][:enable_public_access]
            })
  notifies :restart, "service[firehol]", :immediately
end
