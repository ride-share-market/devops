image = "jenkins"
tag = "1.609.2"

docker_image image do
  tag tag
  action :pull_if_missing
end

docker_container "rsm-jenkins" do
  repo image
  tag tag
  restart_policy "always"
  port [
           "8080:8080"
       ]
  binds [
            "/home/ubuntu/jenkins/jobs-xml:/var/jenkins_home/jobs-xml"
        ]
end
# sudo docker run --rm --name rsm-jenkins -p 8080:8080 -v /home/ubuntu/jenkins/jobs-xml:/var/jenkins_home/jobs-xml jenkins:1.609.2
