default["docker"]["users"] = [
    {:user => "vagrant", :home => "/home/vagrant"},
    {:user => "ubuntu", :home => "/home/ubuntu"}
]

default["hosts"] = {
    :docker_registry_ip => "192.168.33.10",
    :logstash_ip => "192.168.33.10",
    :metrics_ip => "192.168.33.10",
    :rabbitmq_ip => "192.168.33.10",
    :mongodb_ip => "192.168.33.10"
}
