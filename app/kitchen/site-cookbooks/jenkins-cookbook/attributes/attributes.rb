default['jenkins']['master']['port'] = 8081

# As Jenkins is not running the default port of 8080, need to update the Jenkins endpoint
default['jenkins']['master']['endpoint'] = "http://#{node['jenkins']['master']['host']}:#{node['jenkins']['master']['port']}"

default['jenkins-cookbook']['docker_images'] = [
    {
        :name => "iojs",
        :repo => "https://github.com/ride-share-market/iojs.git"
    },
    {
        :name => "logstash-forwarder",
        :repo => "https://github.com/ride-share-market/logstash-forwarder.git"
    },
    {
        :name => "nginx",
        :repo => "https://github.com/ride-share-market/nginx.git"
    }
]
