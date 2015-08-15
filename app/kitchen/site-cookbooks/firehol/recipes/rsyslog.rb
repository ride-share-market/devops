# Set firehol to log to file

service "rsyslog" do
  supports :restart => true
  action :nothing
end

template "/etc/rsyslog.d/10-firehol.conf" do
  source "rsyslog_firehol.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[rsyslog]"
end

logrotate_app "firehol" do
  cookbook "logrotate"
  path "/var/log/firehol.log"
  options ["missingok", "delaycompress", "notifempty"]
  frequency "daily"
  rotate 7
  create "664 root root"
  postrotate "reload rsyslog >/dev/null 2>&1 || true"
end
