jenkins_jobs_dir = node["docker-jenkins"]["jenkins_jobs_dir"]

template "#{jenkins_jobs_dir}/jenkins_install_plugins.sh" do
  source "jenkins_install_plugins.sh.erb"
  owner "ubuntu"
  group "ubuntu"
  mode "0775"
  variables({
                :jenkins_plugins => node["docker-jenkins"]["plugins"]
            })
end
