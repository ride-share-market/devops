template "/etc/init/docker-filter.conf" do
  source "docker-filter.conf"
end

template "/home/ubuntu/docker-filter.sh" do
  source "docker-filter.sh.erb"
  mode "0755"
  owner "ubuntu"
  group "ubuntu"
  variables({
                :lan_hosts => node[:firehol][:lan_hosts],
                :hosts => node[:secrets][:data][:firehol][:hosts],
                :enable_public_access => node[:firehol][:docker][:enable_public_access]
            })
  notifies :restart, "service[firehol]", :immediately
end