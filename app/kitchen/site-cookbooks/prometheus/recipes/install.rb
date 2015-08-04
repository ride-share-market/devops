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

# TODO Containers
# Containers
# sudo docker run -d --name rsm-prometheus -p 9090:9090 -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
# sudo docker run -d --name rsm-node-exporter -p 9100:9100 --net="host" prom/node-exporter
# sudo docker run -d --name rsm-container-exporter -p 9104:9104 -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter

# sudo docker run --rm -p 9102:9102 -p 9125:9125/udp -v $PWD/statsd_mapping.conf:/tmp/statsd_mapping.conf prom/statsd-bridge -statsd.mapping-config=/tmp/statsd_mapping.conf
# echo "node_test.some_service.task.time:500|ms" | nc -w 0 -u localhost 8125

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml"
  owner "ubuntu"
  group "ubuntu"
end
