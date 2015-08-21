#
# Cookbook Name:: docker-grafana
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
image = "grafana/grafana"
tag = "2.1.0"

docker_image image do
  tag tag
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
  repo image
  tag tag
  restart_policy "always"
  links [
            "rsm-prometheus:rsm-prometheus"
        ]
  volumes [
            "/opt/grafana:/var/lib/grafana"
        ]
  binds [
             "/opt/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus"
         ]
  port [
           "3000:3000"
       ]
end
#sudo docker run --rm --name rsm-grafana --link rsm-prometheus:rsm-prometheus -v /opt/grafana-plugins/datasources/prometheus:/usr/share/grafana/public/app/plugins/datasource/prometheus -p 3000:3000 grafana/grafana:2.0.2
