docker_image "prom/prometheus" do
  action :pull_if_missing
end

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml.erb"
  owner "ubuntu"
  group "ubuntu"
  variables({
                :scrape_configs => node["docker-prometheus"]["scrape_configs"]
            })
end

docker_container "rsm-prometheus" do
  repo "prom/prometheus"
  restart_policy 'always'
  # links [
  #           "rsm-node-exporter",
  #           "rsm-container-exporter",
  #           "rsm-statsd-bridge"
  #       ]
  binds [
            "/home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
        ]
  port [
            "9090:9090"
        ]
end
# sudo docker run -d --name rsm-prometheus --link rsm-node-exporter:rsm-node-exporter --link rsm-container-exporter:rsm-container-exporter -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
# sudo docker run -it --name rsm-prometheus --link rsm-node-exporter:rsm-node-exporter --link rsm-container-exporter:rsm-container-exporter -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
# sudo docker run -d --name rsm-prometheus -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus