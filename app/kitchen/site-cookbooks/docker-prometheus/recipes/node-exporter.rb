docker_image "prom/node-exporter" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

docker_container "rsm-node-exporter" do
  detach true
  image "prom/node-exporter"
  container_name "rsm-node-exporter"
  restart "always"
  init_type false
end
# sudo docker run -d --name rsm-node-exporter prom/node-exporter
