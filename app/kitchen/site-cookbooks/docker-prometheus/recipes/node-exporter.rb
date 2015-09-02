docker_image "prom/node-exporter" do
  action :pull_if_missing
end

docker_container "rsm-node-exporter" do
  image "prom/node-exporter"
  restart_policy 'always'
  port [
           "9100:9100"
       ]
end
# sudo docker run -d --name rsm-node-exporter prom/node-exporter
