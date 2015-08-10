prometheus_docker_images = %w(prom/prometheus prom/node-exporter prom/container-exporter)
# prom/statsd-bridge

# Images
prometheus_docker_images.each do |image|
  docker_image image do
    action :pull_if_missing
    # 30 minute timeout allows for slow local env developer connections
    cmd_timeout 1800
  end
end

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml"
  owner "ubuntu"
  group "ubuntu"
end

# Containers
docker_container "rsm-node-exporter" do
  detach true
  image "prom/node-exporter"
  container_name "rsm-node-exporter"
  restart "always"
  init_type false
end
# sudo docker run -d --name rsm-node-exporter prom/node-exporter

docker_container "rsm-container-exporter" do
  detach true
  image "prom/container-exporter"
  container_name "rsm-container-exporter"
  restart "always"
  init_type false
  volume [
             "/sys/fs/cgroup:/cgroup",
             "/var/run/docker.sock:/var/run/docker.sock"
         ]
end
# sudo docker run -d --name rsm-container-exporter -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter

docker_container "rsm-prometheus" do
  detach true
  image "prom/prometheus"
  container_name "rsm-prometheus"
  restart "always"
  init_type false
  link [
           "rsm-node-exporter",
           "rsm-container-exporter"
       ]
  volume "/home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml"
end
# sudo docker run -d --name rsm-prometheus --link rsm-node-exporter:rsm-node-exporter --link rsm-container-exporter:rsm-container-exporter -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

# TODO prom statsd-bridge
# sudo docker run --rm -p 9102:9102 -p 9125:9125/udp -v $PWD/statsd_mapping.conf:/tmp/statsd_mapping.conf prom/statsd-bridge -statsd.mapping-config=/tmp/statsd_mapping.conf
# echo "node_test.some_service.task.time:500|ms" | nc -w 0 -u localhost 8125
