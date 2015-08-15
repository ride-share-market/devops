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
