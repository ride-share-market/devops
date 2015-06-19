# This config file must exist on the target node and contain a valid Jenkins job configuration file.
# Because the Jenkins CLI actually reads and generates its own copy of this file
#
# This file is typically copied from the CI server into the Chef repo
# Chef will write out the file to disk, then point to it for the jenkins_job to read from.

node['jenkins-cookbook']['jobs'].each do |docker|

  xml = File.join(Chef::Config[:file_cache_path], "#{docker[:name]}_config.xml")

  template xml do
    source "config.xml.erb"
    variables({
                  :repo => docker[:repo],
                  :branch => docker.fetch(:branch, "master"),
                  :build_token => node["secrets"]["data"]['jenkins']['build']['token']
              })
  end

  # Create a jenkins job (default action is `:create`)
  jenkins_job docker[:name] do
    config xml
  end

end
