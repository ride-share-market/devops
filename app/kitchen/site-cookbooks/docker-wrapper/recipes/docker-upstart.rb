bash "update_docker_upstart" do
  user "root"
  code <<-EOS
  sed -i -e 's/start\ on.*local-filesystems\ and\ net-device-up.*/start\ on\ started\ firehol/' /etc/init/docker.conf
  EOS
  not_if "grep -q 'start on started firehol' /etc/init/docker.conf"
end
