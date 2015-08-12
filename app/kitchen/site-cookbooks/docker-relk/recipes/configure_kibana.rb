docker_container "rsm-kibana" do
  detach true
  image "kibana:4.1.1"
  container_name "rsm-kibana"
  restart "always"
  init_type false
  link [
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
