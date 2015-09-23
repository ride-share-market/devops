default["docker-jenkins"]["jenkins_home"] = "/home/jenkins"

default["docker-jenkins"]["jenkins_jobs_dir"] = "/home/jenkins/jobs-xml"

default["docker-jenkins"]["app_config_dir"] = "/home/jenkins/jobs-config"

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
