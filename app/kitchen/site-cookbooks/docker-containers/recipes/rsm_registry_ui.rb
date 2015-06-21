docker_image "konradkleine/docker-registry-frontend" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

docker_container "rsm-registry-ui" do
  detach true
  image "konradkleine/docker-registry-frontend"
  container_name "rsm-registry-ui"
  restart "always"
  init_type false
  port "9001:80"
  env [
          "ENV_DOCKER_REGISTRY_HOST=#{node[:hosts][:docker_registry_ip]}",
          "ENV_DOCKER_REGISTRY_PORT=5000"
      ]
end
