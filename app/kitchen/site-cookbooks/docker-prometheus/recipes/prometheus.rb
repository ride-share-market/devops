docker_image "prom/prometheus" do
  action :pull_if_missing
end

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml"
  owner "ubuntu"
  group "ubuntu"
end

docker_container "rsm-prometheus" do
  repo "prom/prometheus"
  restart_policy 'always'
  links [
            "rsm-node-exporter",
            "rsm-container-exporter",
            "rsm-statsd-bridge"
        ]
  binds [
            "/home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
        ]
end
# sudo docker run -d --name rsm-prometheus --link rsm-node-exporter:rsm-node-exporter --link rsm-container-exporter:rsm-container-exporter -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
