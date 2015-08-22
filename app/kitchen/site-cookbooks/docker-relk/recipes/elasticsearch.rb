image = "elasticsearch"
tag = "1.7.1"

docker_image image do
  tag tag
  action :pull_if_missing
end

directory "/opt/elasticsearch/data" do
  recursive true
  owner "root"
  group "root"
  mode "0755"
end

docker_container "rsm-elasticsearch" do
  repo image
  tag tag
  restart_policy "always"
  binds [
             "/opt/elasticsearch/data:/usr/share/elasticsearch/data"
         ]
  command "elasticsearch -Des.node.name=LogstashNode"
end
# sudo docker run --rm -it --name rsm-elasticsearch -v /opt/elasticsearch/data:/usr/share/elasticsearch/data elasticsearch:1.7.1 elasticsearch -Des.node.name=LogstashNode
