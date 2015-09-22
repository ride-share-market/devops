image = "rudijs/docker-logstash-forwarder"
tag = "latest"

docker_image image do
  tag tag
  action :pull_if_missing
end

directory "/etc/logstash/forwarder" do
  recursive true
end

log 'secrets'
log node["secrets"]["data"]["ssl"]["lumberjack"]["certificate"]["path"]

template "/etc/logstash/forwarder/node-exporter.conf" do
  source "node_exporter.conf.erb"
  variables({
                :ssl_certificate => "#{File.join(
                    node["secrets"]["data"]["ssl"]["lumberjack"]["certificate"]["path"],
                    node["secrets"]["data"]["ssl"]["lumberjack"]["certificate"]["name"])}",
                :ssl_key => "#{File.join(
                    node["secrets"]["data"]["ssl"]["lumberjack"]["key"]["path"],
                    node["secrets"]["data"]["ssl"]["lumberjack"]["key"]["name"])}",
                :fqdn => node["fqdn"]
            })
end

logstash_server = []

network = data_bag_item("network", node["docker-lumberjack"]["network"])

network["hosts"].each { |host|

  is_logstash_server = host["roles"].select { |r| r[/^log01$/] }

  if is_logstash_server.size > 0
    # vbx
    if host["cloud"]["ip"]["eth0"] and IPAddress.valid? host["cloud"]["ip"]["eth0"]
      logstash_server.push(host["cloud"]["ip"]["eth0"])
    end
    # aws
    if host["cloud"]["ip"]["eni"] and IPAddress.valid? host["cloud"]["ip"]["eni"]["eth0"]
      logstash_server.push(host["cloud"]["ip"]["eni"]["eth0"])
    end
  end
}

# should be only one logstash server, role log01, per network
if logstash_server.size != 1
  raise "Should be a single logstash (role log01) server per network: #{node["docker-lumberjack"]["network"]}"
end

docker_container "rsm-logstash-forwarder" do
  repo image
  tag tag
  restart_policy "always"
  binds [
            "/etc/pki:/etc/pki:ro",
            "/etc/logstash/forwarder:/etc/logstash/forwarder:ro",
            "/var/log:/host/var/log:ro"
        ]
  extra_hosts [
                  "logstash.ridesharemarket.com:#{logstash_server[0]}"
              ]
  # command "--config=/etc/logstash/forwarder/node-exporter.conf --silent"
  command "--config=/etc/logstash/forwarder/node-exporter.conf"
end

# sudo docker run --rm -it --name logstash-forwarder --user root
# --add-host logstash.ridesharemarket.com:192.168.33.100
# -v /etc/pki/tls:/etc/pki/tls:ro
# -v /var/log:/host/var/log:ro
# -v /etc/logstash/forwarder:/etc/logstash/forwarder:ro
# -t rudijs/docker-logstash-forwarder '--config=/etc/logstash/forwarder/logstash-forwarder.conf'
