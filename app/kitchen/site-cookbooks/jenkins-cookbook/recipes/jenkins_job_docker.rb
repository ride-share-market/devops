node['jenkins-cookbook']['docker_images'].each do |docker|

  xml = File.join(Chef::Config[:file_cache_path], "#{docker[:name]}_config.xml")

  template xml do
    source "docker_config.xml.erb"
    variables({
                  :repo => docker[:repo],
                  :branch => docker.fetch(:branch, "develop")
              })
  end

  # Create a jenkins job (default action is `:create`)
  jenkins_job docker[:name] do
    config xml
  end

end
