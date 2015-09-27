template "/home/ubuntu/mongodb_backup.sh" do
  source "mongodb_backup.sh.erb"
  owner "ubuntu"
  group "ubuntu"
  mode "0775"
end

cron "Backup MongoDB RSM Database" do
  minute 0
  hour 1
  user "ubuntu"
  mailto "root"
  # command "/home/ubuntu/trim-logstash-index.sh > /dev/null"
  command "/home/ubuntu/mongodb_backup.sh"
end
