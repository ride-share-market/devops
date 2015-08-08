docker_image "grafana/grafana" do
  action :pull_if_missing
  # 30 minute timeout allows for slow local env developer connections
  cmd_timeout 1800
end

git "/opt/grafana-plugins" do
  repository "https://github.com/grafana/grafana-plugins.git"
  not_if { ::File.exists?("/opt/grafana-plugins") }
end

docker_container "rsm-grafana" do
  detach true
  image "grafana/grafana"
  container_name "rsm-grafana"
  restart "always"
  init_type false
  link "rsm-prometheus:rsm-prometheus"
  volume "/opt/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus"
  port "3000:3000"
end
# sudo docker run -d --name rsm-grafana --link rsm-prometheus:rsm-prometheus -v $(pwd)/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus -p 3000:3000 grafana/grafana
