image = "kibana"
tag = "4.1.1"

docker_image image do
  tag tag
  action :pull_if_missing
end

docker_container "rsm-kibana" do
  repo image
  tag tag
  container_name "rsm-kibana"
  restart_policy "always"
  links [
           "rsm-elasticsearch:elasticsearch"
       ]
  port [
           "5601:5601"
       ]
end
# sudo docker run --rm -it --name rsm-kibana \
#     --link rsm-elasticsearch:elasticsearch \
#     -p 5601:5601 \
#     kibana
