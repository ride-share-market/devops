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
