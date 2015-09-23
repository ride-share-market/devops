image = "rudijs/jenkins-build-essential"
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
            "#{node["docker-jenkins"]["jenkins_home"]}:/var/jenkins_home"
        ]
  links [
            "rsm-rabbitmq:rsm-rabbitmq",
            "rsm-mongodb:rsm-mongodb",
            "rsm-couchbase:rsm-couchbase",
            "rsm-statsd-bridge:rsm-statsd-bridge"
        ]
end
# sudo docker run --rm --name rsm-jenkins -p 8080:8080 -v /home/jenkins:/var/jenkins_home jenkins:1.609.2
