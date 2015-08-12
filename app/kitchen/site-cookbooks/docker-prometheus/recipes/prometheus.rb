docker_image "prom/prometheus" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml"
  owner "ubuntu"
  group "ubuntu"
end

docker_container "rsm-prometheus" do
  detach true
  image "prom/prometheus"
  container_name "rsm-prometheus"
  restart "always"
  init_type false
  link [
           "rsm-node-exporter",
           "rsm-container-exporter",
           "rsm-statsd-bridge"
       ]
  volume "/home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml"
end
# sudo docker run -d --name rsm-prometheus --link rsm-node-exporter:rsm-node-exporter --link rsm-container-exporter:rsm-container-exporter -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
