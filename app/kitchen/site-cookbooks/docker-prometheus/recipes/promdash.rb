docker_image "prom/promdash" do
  action :pull_if_missing
end

directory "/opt/promdash" do
  owner "root"
  group "root"
  mode "0775"
end

if !File.exists?("/opt/promdash/file.sqlite3")
  execute "create Promdash SQLite3 database" do
    command "sudo docker run -v /opt/promdash:/opt/promdash -e DATABASE_URL=sqlite3:/opt/promdash/file.sqlite3 prom/promdash ./bin/rake db:migrate"
    retries 3
    retry_delay 5
  end
end


docker_container "rsm-promdash" do
  image "prom/promdash"
  restart_policy "always"
  env [
          "DATABASE_URL=sqlite3:/opt/promdash/file.sqlite3"
      ]
  binds [
            "/opt/promdash:/opt/promdash"
        ]
  port [
           "3000:3000"
       ]
end
