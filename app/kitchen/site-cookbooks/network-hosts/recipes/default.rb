#
# Cookbook Name:: network-hosts
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
node["network-hosts"].each { |network|

  network_parts = network.split('_')

  environment = network_parts[0]

  location = network_parts[1]

  domain = "#{network_parts[2]}.com"

  network_hosts = data_bag_item("network", network)

  network_hosts["hosts"].each { |host|

    host_aliases = [
        "#{host["id"]}.#{domain}",
        host["cnames"]
    ]

    host_lan_aliases = [
        "lan.#{host["id"]}.#{domain}"
    ]

    if host["roles"]
      host["roles"].each { |role|
        host_aliases.push("#{role}.#{environment}.#{location}.#{domain}")

        if host["cloud"]["ip"]["eni"] and IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]
          host_lan_aliases.push("lan.#{role}.#{environment}.#{location}.#{domain}")
        end
      }
    end

    # Virtualbox machines
    if IPAddress.valid? host["cloud"]["ip"]["eth0"]
      hostsfile_entry host["cloud"]["ip"]["eth0"] do
        hostname host['id']
        unique true
        action :create
        aliases host_aliases
      end
    end

    # AWS machines
    if IPAddress.valid? host["cloud"]["ip"]["eip"]
      hostsfile_entry host["cloud"]["ip"]["eip"] do
        hostname host['id']
        unique true
        action :create
        aliases host_aliases
      end
    end

    if host["cloud"]["ip"]["eni"] and IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]
      hostsfile_entry host["cloud"]["ip"]["eni"]["eth0"] do
        hostname "lan.#{host['id']}"
        unique true
        action :create
        aliases host_lan_aliases
      end
    end

  }

}
