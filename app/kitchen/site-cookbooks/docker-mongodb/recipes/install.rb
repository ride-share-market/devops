image = "mongo"
tag = "2.6.11"

docker_image image do
  tag tag
  action :pull_if_missing
end

docker_container "rsm-mongodb" do
  repo image
  tag tag
  restart_policy "always"
  port [
           "27017:27017"
       ]
end
# sudo docker run --rm --name rsm-mongodb -p 27017:27017 mongo:2.6.11
