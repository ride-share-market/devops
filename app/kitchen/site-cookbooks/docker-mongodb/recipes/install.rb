image = "mongo"
tag = "2.6.11"

docker_image image do
  tag tag
  action :pull_if_missing
end

directory "/opt/mongodb" do
  recursive true
  owner "root"
  group "root"
  mode "0775"
end

docker_container "rsm-mongodb" do
  repo image
  tag tag
  restart_policy "always"
  binds [
            "/opt/mongodb/db:/data/db",
            "/opt/backup/mongodb:/opt/backup/mongodb"
        ]
  port [
           "27017:27017"
       ]
end
# sudo docker run -d --name rsm-mongodb -v /opt/mongodb/db:/data/db -v /opt/backup/mongodb:/opt/backup/mongodb -p 27017:27017 mongo:2.6.11
