docker_image "prom/container-exporter" do
  action :pull_if_missing
end

docker_container "rsm-container-exporter" do
  image "prom/container-exporter"
  restart_policy 'always'
  binds [
            "/sys/fs/cgroup:/cgroup",
            "/var/run/docker.sock:/var/run/docker.sock"
        ]
end
# sudo docker run -d --name rsm-container-exporter -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter
