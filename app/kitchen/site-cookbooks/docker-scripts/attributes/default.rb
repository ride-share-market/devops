default["docker"]["users"] = [
    {:user => "vagrant", :home => "/home/vagrant"},
    {:user => "ubuntu", :home => "/home/ubuntu"}
]

default["hosts"] = {
    :docker_registry_ip => "192.168.33.100",
    :logstash_ip => "192.168.33.100",
    :metrics_ip => "192.168.33.100",
    :rabbitmq_ip => "192.168.33.100",
    :mongodb_ip => "192.168.33.100",
    :couchbase_ip => "192.168.33.100"
}
