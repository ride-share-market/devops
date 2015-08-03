remote_file "/opt/grafana-2.0.2.linux-x64.tar.gz" do
  source "https://grafanarel.s3.amazonaws.com/builds/grafana-2.0.2.linux-x64.tar.gz"
  not_if { File.exists?("/opt/grafana-2.0.2.linux-x64.tar.gz") }
end

execute "extract_grafana" do
  command "tar -xzvf /opt/grafana-2.0.2.linux-x64.tar.gz"
  cwd "/opt"
  not_if { File.exists?("/opt/grafana-2.0.2") }
end

git "/opt/grafana-plugins" do
  repository "https://github.com/grafana/grafana-plugins.git"
  not_if { ::File.exists?("/opt/grafana-plugins") }
end

execute "install_grafana_prometheus_plugin" do
  command "cp -a grafana-plugins/datasources/prometheus grafana-2.0.2/public/app/plugins/datasource"
  cwd "/opt"
  not_if { ::File.exists?("/opt/grafana-2.0.2/public/app/plugins/datasource/prometheus") }
end
