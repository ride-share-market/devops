require "json"

class AwsServer

  def initialize
    @network = "prd_aws_ridesharemarket"
    @file_path = File.join(File.dirname(__FILE__), "/../kitchen/data_bags/network/#{@network}.json")
    @data_hash = JSON.parse(File.read(@file_path))
  end

  def pretty_print(hash)
    puts JSON.pretty_generate(hash)
  end

  def strip_sub_domains(uri)
    domain_parts = uri.split('_')
    domain_parts[2]
  end

  def hosts
    puts @data_hash["hosts"].map { |host|
           puts "Hostname: #{host["id"]}.#{strip_sub_domains @data_hash["id"]}.com (Roles: #{host["roles"].join(",")})"
         }
  end

  def bootstrap(name, chef_client_version, lan)
    puts "==> Bootstrapping AWS Server: #{name}"

    new_server = @data_hash["hosts"].select { |host|
      host["id"] == name
    }

    raise "Host not found: #{name}" if new_server.size == 0

    hostname = name

    if lan == "yes"
      hostname = "lan.#{name}"
    end

    cmd = "knife bootstrap #{hostname} --yes --sudo --node-name #{name} --bootstrap-version #{chef_client_version} --ssh-user ubuntu --run-list '#{new_server[0]["chefBootstrap"]["runList"].join(",")}' --json-attributes '#{new_server[0]["chefBootstrap"]["jsonAttributes"].to_json}'"
    puts "==> #{cmd}"; system cmd

  end

  def delete_server(name)

    puts "==> Deleting AWS server instance and Chef Server Node: #{name}"

    new_server = @data_hash["hosts"].select { |host|
      host["id"] == name
    }

    raise "Host not found: #{name}" if new_server.size == 0

    cmd = "aws ec2 terminate-instances --instance-ids #{new_server[0]["cloud"]["id"]}"
    puts "==> #{cmd}"; system cmd

    cmd = "knife node delete #{name} --yes"
    puts "==> #{cmd}"; system cmd

    cmd = "knife client delete #{name} --yes"
    puts "==> #{cmd}"; system cmd

    cmd = "ssh-keygen -f /home/rudi/.ssh/known_hosts -R #{new_server[0]["cloud"]["ip"]["eth0"]}"
    puts "==> #{cmd}"; system cmd

    cmd = "ssh-keygen -f /home/rudi/.ssh/known_hosts -R #{new_server[0]["id"]}"
    puts "==> #{cmd}"; system cmd

    if new_server[0]["roles"]
      new_server[0]["roles"].each { |role|
        cmd = "ssh-keygen -f /home/rudi/.ssh/known_hosts -R #{role}.#{@network}"
        puts "==> #{cmd}"; system cmd
      }
    end

    if new_server[0]["cnames"]
      new_server[0]["cnames"].each { |cname|
        cmd = "ssh-keygen -f /home/rudi/.ssh/known_hosts -R #{cname}"
        puts "==> #{cmd}"; system cmd
      }
    end

    cmd = "ssh-keygen -f /home/rudi/.ssh/known_hosts -R #{new_server[0]["chefBootstrap"]["jsonAttributes"]["set_fqdn"]}"
    puts "==> #{cmd}"; #system cmd

    puts "==> Manually remove Elastic IP if no longer required"
    puts "==> aws ec2 describe-addresses"
    puts "==> aws ec2 release-address --allocation-id eipalloc-XXXXXX"

  end

  def uptime
    @data_hash["hosts"].each { |host|
      cmd = "ssh -oStrictHostKeyChecking=no root@#{host["id"]} uptime"
      puts cmd; system cmd
    }
  end

end
