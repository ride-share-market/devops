template "/sbin/firehol" do
  source "firehol.in"
  mode 0755
end

template "/etc/init/firehol.conf" do
  source "etc_init_firehol.conf"
end

directory "/etc/firehol" do
  action :create
end

service "firehol" do
    supports :restart => true, :reload => true
    action :nothing
end
