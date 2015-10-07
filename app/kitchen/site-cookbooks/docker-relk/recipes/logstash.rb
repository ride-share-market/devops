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
  restart_policy "always"
  binds [
             "/etc/logstash/conf.d:/etc/logstash/conf.d:ro",
             "/etc/pki:/etc/pki:ro"
             # "/var/log:/host/var/log:ro",
             # "/opt/logstash-since_db:/opt/logstash-since_db:rw"
         ]
  links [
           "rsm-rabbitmq:rsm-rabbitmq",
           "rsm-elasticsearch:rsm-elasticsearch"
       ]
  port [
           "1514:1514",
           "1514:1514/udp",
           "9876:9876",
           "9877:9877"
       ]
  # user "root"
  # command "/opt/logstash/bin/logstash -f /etc/logstash/conf.d"
  command "logstash -f /etc/logstash/conf.d --debug"
end

# One time commands to fix/update logstash rabbitmq plugins
# Issue:
# https://github.com/logstash-plugins/logstash-output-rabbitmq/issues/9

check_file = "/home/ubuntu/docker-check_file_rsm-logstash.txt"

if File.exists?(check_file)
  log "Aborting recipe logstash - one time rabbitmq plugin update on initial container instance."
  log "Remove #{check_file} to proceed with recipe"
  return
end

update_rabbitmq_plugins_commands = [
    "docker exec rsm-logstash /opt/logstash/bin/plugin update logstash-output-rabbitmq logstash-input-rabbitmq",
    "docker stop rsm-logstash",
    "docker start rsm-logstash"
]

update_rabbitmq_plugins_commands.each do |command|
  execute "update_logstash_rabbitmq_plugins" do
    command command
    retries 5
    retry_delay 3
  end
end

file check_file do
  action :create
end

# sudo docker run -it --rm --user root --name rsm-logstash
# -v /etc/logstash/conf.d:/etc/logstash/conf.d:ro
# -v /etc/pki:/etc/pki:ro
# -v /var/log:/host/var/log:ro
# -v /opt/logstash-since_db:/opt/logstash-since_db:rw
# -p 9876:9876
# --link rsm-elasticsearch:els.dev.vbx.ridesharemarket.com
# logstash:1.5.2 /opt/logstash/bin/logstash -f /etc/logstash/conf.d --debug

# Manual update for logstash:1:5:2
# sudo docker exec rsm-logstash /opt/logstash/bin/plugin update logstash-output-rabbitmq logstash-input-rabbitmq
# sudo docker stop rsm-logstash
# sudo docker start rsm-logstash
