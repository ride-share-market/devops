image = "rabbitmq"
tag = "3.5.4-management"

docker_image image do
  tag tag
  action :pull_if_missing
end

check_file = "/home/ubuntu/docker-check_file_rsm-rabbitmq.txt"
if File.exists?(check_file)
  log "Aborting recipe rabbitmq - one time configuration on initial container instance required."
  log "Remove #{check_file} to proceed with recipe"
  return
end

docker_container "rsm-rabbitmq" do
  repo image
  tag tag
  container_name "rsm-rabbitmq"
  restart_policy "always"
  hostname "rsm-rabbit"
  port [
           "5672:5672",
           "15672:15672"
       ]
  env [
          "RABBITMQ_DEFAULT_USER=admin",
          "RABBITMQ_DEFAULT_PASS=#{node["secrets"]["data"]["rabbitmq"]["users"]["admin"]["password"]}"
      ]
end
# sudo docker run --rm -it --hostname my-rabbit --name some-rabbit \
#    -p 5672:5672 -p 15672:15672 \
#    rabbitmq:management

# Create /rsm vhost
execute "add_vhost rsm" do
  command "docker exec rsm-rabbitmq rabbitmqctl add_vhost rsm"
  retries 5
  retry_delay 3
end

# Create user accounts
["rsm", "rsm-logstash"].each do |user|

  execute "add_user #{user}" do
    command "docker exec rsm-rabbitmq rabbitmqctl add_user #{user} #{node["secrets"]["data"]["rabbitmq"]["users"][user]["password"]}"
    retries 5
    retry_delay 3
  end

end

# Vhost /rsm permissions
["admin", "rsm", "rsm-logstash"].each do |user|

  execute "set_permissions -p rsm #{user}" do
    command "docker exec rsm-rabbitmq rabbitmqctl set_permissions -p rsm #{user} '.*' '.*' '.*'"
    retries 5
    retry_delay 3
  end

end

file check_file do
  action :create
end