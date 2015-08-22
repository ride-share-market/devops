docker_image "registry" do
  action :pull_if_missing
end

docker_container "rsm-registry" do
  repo "registry"
  restart_policy "always"
  port [
           "5000:5000"
       ]
end
