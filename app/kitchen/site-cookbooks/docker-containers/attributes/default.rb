default["docker"]["users"] = [
    {:user => "vagrant", :home => "/home/vagrant"},
    {:user => "ubuntu", :home => "/home/ubuntu"}
]

default["docker_registry_ui"] = {
    :docker_registry_host => "192.168.33.10"
}
