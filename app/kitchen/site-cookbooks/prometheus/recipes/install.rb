prometheus_docker_images = %w(prom/prometheus prom/node-exporter prom/container-exporter)

# Images
prometheus_docker_images.each do |image|
  docker_image image do
    action :pull_if_missing
    # 30 minute timeout allows for slow local env developer connections
    cmd_timeout 1800
  end
end

# Containers
# TODO containers

# Configuration File
template "/home/ubuntu/prometheus.yml" do
  source "prometheus.yml"
  owner "ubuntu"
  group "ubuntu"
end
