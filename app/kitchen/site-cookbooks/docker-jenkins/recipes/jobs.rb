# This config file must exist on the target node and contain a valid Jenkins job configuration file.
# Because the Jenkins CLI actually reads and generates its own copy of this file
#
# This file is typically copied from the CI server into the Chef repo
# Chef will write out the file to disk, then point to it for the jenkins_job to read from.
jenkins_jobs_dir = node["docker-jenkins"]["jenkins_jobs_dir"]

directory jenkins_jobs_dir do
  recursive true
  owner 1000
  group 1000
end

# Create XML file for each job
node["docker-jenkins"]["jobs"].each do |job|

  template "#{jenkins_jobs_dir}/#{job[:name]}_config.xml" do
    source "config.xml.erb"
    variables({
                  :repo => job[:repo],
                  :branch => job.fetch(:branch, "master"),
                  :build_token => node["secrets"]["data"]["jenkins"]["build"]["token"]
              })
  end

end

# Create the shell commands to run inside container that will create the jobs
template "#{jenkins_jobs_dir}/jenkins_create_jobs.sh" do
  source "jenkins_create_jobs.sh.erb"
  owner "ubuntu"
  group "ubuntu"
  mode "0775"
  variables({
               :jenkins_jobs => node["docker-jenkins"]["jobs"]
           })
end
