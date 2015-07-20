template "/home/ubuntu/trim-logstash-index.sh" do
  source "trim-logstash-index.sh.erb"
  owner "ubuntu"
  group "ubuntu"
  mode "0775"
end

cron "Trim logstash index at midnight" do
  minute 0
  hour 0
  user "ubuntu"
  mailto "root"
  # command "/home/ubuntu/trim-logstash-index.sh > /dev/null"
  command "/home/ubuntu/trim-logstash-index.sh"
end
