#!/usr/bin/env ruby

require "json"
require "ipaddress"

class NetworkHosts
  def initialize
    @path = File.dirname(__FILE__) + "/../kitchen/data_bags/network"
  end

  def network_data_bags
    Dir.glob("#{@path}/*.json")
  end

  def read_json(file)
    JSON.parse(File.read(file))
  end

  def network_uri(id)
    network_parts = id.split('_')
    uri = {
        :environment => network_parts[0],
        :location => network_parts[1],
        :domain => "#{network_parts[2]}.com"
    }
  end

  def host_roles(uri, roles)
    urls = []
    roles.each {|role|
      urls.push("#{role}.#{uri[:environment]}.#{uri[:location]}.#{uri[:domain]}")
    }
    urls
  end

  def host_unique_name(uri, id)
    unique_name = [id, "#{id}.#{uri[:domain]}"]
  end

  def hosts_entries

    hosts_comment = "### Ride Share Market: #{Time.now.strftime("%Y-%m-%d")}"
    puts hosts_comment

    network_data_bags.each { |data_bag|
      obj = read_json(data_bag)
      uri = network_uri(obj["id"])

      obj["hosts"].each {|host|

        hosts = []

        hosts += host_unique_name(uri, host["id"])
        hosts += host_roles(uri, host["roles"])
        if host["cnames"]
          hosts += host["cnames"]
        end

        # Vagrant machines
        if IPAddress.valid? host["cloud"]["ip"]["eth0"]
          puts "# VirtualBox Server #{host["cloud"]["id"]}"
          puts "#{host["cloud"]["ip"]["eth0"]} #{hosts.join(" ")}"
        end

        # AWS machines
        if IPAddress.valid? host["cloud"]["ip"]["eip"]
          puts "# Cloud Server ID #{host["cloud"]["id"]}"
          puts "#{host["cloud"]["ip"]["eip"]} #{hosts.join(" ")}"
        end

      }

    }

  end

end

network_hosts = NetworkHosts.new

network_hosts.hosts_entries
