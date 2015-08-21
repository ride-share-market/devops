#
# Cookbook Name:: docker-grafana
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
docker_image "grafana/grafana" do
  action :pull_if_missing
end

git "/opt/grafana-plugins" do
  repository "https://github.com/grafana/grafana-plugins.git"
  not_if { ::File.exists?("/opt/grafana-plugins") }
end

directory "/opt/grafana" do
  owner "root"
  group "root"
  mode "0775"
end

docker_container "rsm-grafana" do
  image "grafana/grafana"
  container_name "rsm-grafana"
  restart_policy "always"
  links [

        ]
  volumes [
             "/opt/grafana:/var/lib/grafana",
             "/opt/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus"
         ]
  port [
           "3000:3000"
       ]
end
# sudo docker run -d --name rsm-grafana --link rsm-prometheus:rsm-prometheus -v $(pwd)/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus -p 3000:3000 grafana/grafana
