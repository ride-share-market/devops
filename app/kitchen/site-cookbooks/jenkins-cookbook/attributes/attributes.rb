default['jenkins']['master']['port'] = 8081

# As Jenkins is not running the default port of 8080 (see previous config), need to update the Jenkins endpoint
default['jenkins']['master']['endpoint'] = "http://#{node['jenkins']['master']['host']}:#{node['jenkins']['master']['port']}"

default['jenkins-cookbook']['jobs'] = [
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
    },
    {
        :name => "data",
        :repo => "https://github.com/ride-share-market/data.git"
    },
    {
        :name => "api",
        :repo => "https://github.com/ride-share-market/api.git"
    },
    {
        :name => "app",
        :repo => "https://github.com/ride-share-market/app.git"
    }
]
