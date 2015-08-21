image = "logstash"
tag = "1.5.2"

docker_image image do
  tag tag
  action :pull_if_missing
end

directory "/etc/logstash/conf.d" do
  recursive true
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
  repo image
  tag tag
  container_name "rsm-logstash"
  restart_policy "always"
  volumes [
             "/etc/logstash/conf.d:/etc/logstash/conf.d:ro",
             "/etc/pki:/etc/pki:ro",
             "/var/log:/host/var/log:ro",
             "/opt/logstash-since_db:/opt/logstash-since_db:rw"
         ]
  links [
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
# -v /opt/logstash-since_db:/opt/logstash-since_db:rw
# -p 9876:9876
# --link rsm-elasticsearch:els.dev.vbx.ridesharemarket.com
# logstash:1.5.2 /opt/logstash/bin/logstash -f /etc/logstash/conf.d --debug

#sudo docker run -d --user root --name rsm-logstash -v /etc/logstash/conf.d:/etc/logstash/conf.d:ro -v /etc/pki:/etc/pki:ro -v /var/log:/host/var/log:ro -v /opt/logstash-since_db:/opt/logstash-since_db:rw -p 9876:9876 --link rsm-elasticsearch:els.dev.vbx.ridesharemarket.com logstash:1.5.2 /opt/logstash/bin/logstash -f /etc/logstash/conf.d --debug
#sudo docker exec rsm-logstash /opt/logstash/bin/plugin update logstash-output-rabbitmq logstash-input-rabbitmq
