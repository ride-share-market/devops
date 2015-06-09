docker_image "registry" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

docker_container "rsm-registry" do
  detach true
  image "registry"
  container_name "rsm-registry"
  restart "always"
  init_type false
  port "5000:5000"
end
