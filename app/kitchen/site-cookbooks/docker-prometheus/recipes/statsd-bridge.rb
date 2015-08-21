docker_image "prom/statsd-bridge" do
  action :pull_if_missing
end

template "/home/ubuntu/statsd_mapping.conf" do
  source "statsd_mapping.conf"
  owner "ubuntu"
  group "ubuntu"
end

docker_container "rsm-statsd-bridge" do
  repo "prom/statsd-bridge"
  restart_policy 'always'
  binds [
            "/home/ubuntu/statsd_mapping.conf:/tmp/statsd_mapping.conf"
        ]
  port [
           "9102:9102",
           "9125:9125/udp"
       ]
  command "-statsd.mapping-config=/tmp/statsd_mapping.conf"
end
# sudo docker run --rm -it --name rsm-statsd-bridge -p 9102:9102 -p 9125:9125/udp -v /home/ubuntu/statsd_mapping.conf:/tmp/statsd_mapping.conf prom/statsd-bridge -statsd.mapping-config=/tmp/statsd_mapping.conf

# echo "node_test.some_service.task.time:500|ms" | nc -w 0 -u localhost 9125
