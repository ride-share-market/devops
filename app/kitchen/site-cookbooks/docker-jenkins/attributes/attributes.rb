default["docker-jenkins"]["jenkins_jobs_dir"] = "/home/ubuntu/jenkins/jobs-xml"

default["docker-jenkins"]["plugins"] = [
    "greenballs",
    "git"
]

default["docker-jenkins"]["jobs"] = [
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
