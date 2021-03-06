node["docker"]["users"].each {|user|

  template "#{user[:home]}/docker-build.rb" do
    source "docker-build.rb"
    owner user[:user]
    group user[:user]
  end

  template "#{user[:home]}/docker_registry_latest_versions.rb" do
    source "docker_registry_latest_versions.rb"
    owner user[:user]
    group user[:user]
  end

  template "#{user[:home]}/docker-purge.sh" do
    source "docker-purge.sh.erb"
    owner user[:user]
    group user[:user]
    mode 0775
    variables({
                  :docker_registry_ip => node["hosts"][:docker_registry_ip]
              })
  end

  template "#{user[:home]}/docker-deploy.rb" do
    source "docker-deploy.rb.erb"
    owner user[:user]
    group user[:user]
    variables({
                  :logstash_ip => node["hosts"][:logstash_ip],
                  :metrics_ip => node["hosts"][:metrics_ip],
                  :rabbitmq_ip => node["hosts"][:rabbitmq_ip],
                  :mongodb_ip => node["hosts"][:mongodb_ip],
                  :couchbase_ip => node["hosts"][:couchbase_ip]
              })
  end

  template "#{user[:home]}/docker_registry.rb" do
    source "docker_registry.rb"
    owner user[:user]
    group user[:user]
  end

}
