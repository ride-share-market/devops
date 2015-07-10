node["docker"]["users"].each {|user|

  template "#{user[:home]}/docker-deploy.rb" do
    source "docker-deploy.rb.erb"
    owner user[:user]
    group user[:user]
    variables({
                  :logstash_ip => node["hosts"][:logstash_ip],
                  :metrics_ip => node["hosts"][:metrics_ip],
                  :rabbitmq_ip => node["hosts"][:rabbitmq_ip],
                  :mongodb_ip => node["hosts"][:mongodb_ip]
              })
  end

  template "#{user[:home]}/docker_registry.rb" do
    source "docker_registry.rb"
    owner user[:user]
    group user[:user]
  end

  template "#{user[:home]}/docker-build.rb" do
    source "docker-build.rb"
    owner user[:user]
    group user[:user]
  end

}
