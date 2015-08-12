docker_image "prom/container-exporter" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

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
