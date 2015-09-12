# SSH Forwarding into private subnet
node["iptables-rules"]["network-hosts"].each { |network|

  network_hosts = data_bag_item("network", network)

  network_hosts["hosts"].each { |host|

    is_ssh_server_node = host["roles"].select { |r| r[/^ssh/] }

    # If not ssh/bastion server add ssh port forwarding to it
    if is_ssh_server_node.length == 0
      if host["cloud"]["ip"]["eni"] and IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]
        iptables_rule "dnat_ssh" do
          action :enable
          variables ({
                        :ip => host["cloud"]["ip"]["eni"]["eth0"],
                        :port => host["cloud"]["ip"]["eni"]["portForward"]
                    })
        end
      end
    end

  }

}
