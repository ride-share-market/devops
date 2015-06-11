# This config file must exist on the target node and contain a valid Jenkins job configuration file.
# Because the Jenkins CLI actually reads and generates its own copy of this file
#
# This file is typically copied from the CI server into the Chef repo
# Chef will write out the file to disk, then point to it for the jenkins_job to read from.

xml = File.join(Chef::Config[:file_cache_path], 'app-config.xml')

template xml do
  source 'app-config.xml.erb'
end

# Create a jenkins job (default action is `:create`)
jenkins_job 'app' do
  config xml
end
