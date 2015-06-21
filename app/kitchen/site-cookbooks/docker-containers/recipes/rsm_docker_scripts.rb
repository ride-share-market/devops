node["docker"]["users"].each {|user|

  template "#{user[:home]}/docker-deploy.rb" do
    source "docker-deploy.rb.erb"
    owner user[:user]
    group user[:user]
    variables({
                  :logstash_ip => "192.168.33.10",
                  :metrics_ip => "192.168.33.10"
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
