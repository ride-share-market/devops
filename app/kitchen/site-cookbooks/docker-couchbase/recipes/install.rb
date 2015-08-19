image = "couchbase:community-3.0.1"

docker_image image do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

docker_container "rsm-couchbase" do
  detach true
  image image
  container_name "rsm-couchbase"
  restart "always"
  init_type false
  port [
           "8091:8091",
           "11210:11210",
           "11212:11212"
       ]
  # ulimit [
  #            "nofile=40960:40960",
  #            "core=100000000:100000000"
  #        ]
end
# sudo docker run --rm --name rsm-couchbase -p 8091:8091 -p 11210:11210 -p 11212:11212 couchbase:community-3.0.1
# sudo docker run --rm --name rsm-couchbase -p 8091:8091 -p 11210:11210 -p 11212:11212 --ulimit nofile=40960:40960 --ulimit core=100000000:100000000 --ulimit memlock=100000000:100000000 couchbase:community-3.0.1

# notes
# docker run -d --ulimit nofile=40960:40960 --ulimit core=100000000:100000000 --ulimit memlock=100000000:100000000 couchbase/server
