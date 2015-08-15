image = "logstash:1.5.2"

docker_image image do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

rules = []
rules.push(node["logstash"]["settings"]["rules"])
# rules.push(node["logstash"]["rules"]["services"])

rules.flatten.each do |f|
  template "/etc/logstash/conf.d/#{f}" do
    source "#{f}.erb"
    owner 'root'
    group 'root'
    mode '0644'
    variables({
                  :settings => node["logstash"]["settings"],
                  :rabbitmq_password => node["secrets"]["data"]["rabbitmq"]["users"][node["logstash"]["settings"]["rabbitmq_user"]]["password"]
              })
    # notifies :restart, "service[logstash]"
  end
end

docker_container "rsm-logstash" do
  detach true
  image image
  container_name "rsm-logstash"
  restart "always"
  init_type false
  volume [
             "/etc/logstash/conf.d:/etc/logstash/conf.d:ro",
             "/etc/pki:/etc/pki:ro",
             "/var/log:/host/var/log:ro"
         ]
  link [
           "rsm-elasticsearch:rsm-elasticsearch"
       ]
  port [
           "9876:9876"
       ]
  user "root"
  command "/opt/logstash/bin/logstash -f /etc/logstash/conf.d"
end

# sudo docker run -it --rm --user root --name rsm-logstash
# -v /etc/logstash/conf.d:/etc/logstash/conf.d:ro
# -v /etc/pki:/etc/pki:ro
# -v /var/log:/host/var/log:ro
# -p 9876:9876
# --link rsm-elasticsearch:els.dev.vbx.ridesharemarket.com
# logstash:1.5.2 /opt/logstash/bin/logstash -f /etc/logstash/conf.d --debug
