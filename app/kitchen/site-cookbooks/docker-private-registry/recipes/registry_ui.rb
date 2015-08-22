docker_image "konradkleine/docker-registry-frontend" do
  action :pull_if_missing
end

docker_container "rsm-registry-ui" do
  repo "konradkleine/docker-registry-frontend"
  restart_policy "always"
  port [
           "9001:80"
       ]
  env [
          "ENV_DOCKER_REGISTRY_HOST=#{node[:hosts][:docker_registry_ip]}",
          "ENV_DOCKER_REGISTRY_PORT=5000"
      ]
end
