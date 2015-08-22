image = "couchbase"
tag = "community-3.0.1"

docker_image image do
  tag tag
  action :pull_if_missing
end

docker_container "rsm-couchbase" do
  repo image
  tag tag
  restart_policy "always"
  privileged true
  port [
           "8091:8091",
           "11210:11210",
           "11212:11212"
       ]
  ulimits [
              {'Name' => 'nofile', 'Soft' => 40960, 'Hard' => 40960},
              {'Name' => 'core', 'Soft' => 100000000, 'Hard' => 100000000},
              {'Name' => 'memlock', 'Soft' => 100000000, 'Hard' => 100000000}
          ]
end
# sudo docker run --rm --name rsm-couchbase -p 8091:8091 -p 11210:11210 -p 11212:11212 --ulimit nofile=40960:40960 --ulimit core=100000000:100000000 --ulimit memlock=100000000:100000000 couchbase:community-3.0.1
