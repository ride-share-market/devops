image = "elasticsearch:1.7.1"

docker_image image do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

directory "/opt/esdata" do
  owner "root"
  group "root"
  mode "0755"
end

docker_container "rsm-elasticsearch" do
  detach true
  image image
  container_name "rsm-elasticsearch"
  restart "always"
  init_type false
  volume [
             "/opt/esdata:/usr/share/elasticsearch/data"
         ]
  command "elasticsearch -Des.node.name=LogstashNode"
end
# sudo docker run --rm -it --name rsm-elasticsearch -v /opt/esdata:/usr/share/elasticsearch/data elasticsearch:1.7.1 elasticsearch -Des.node.name=LogstashNode
