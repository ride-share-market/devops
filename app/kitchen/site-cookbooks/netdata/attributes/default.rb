default["netdata"]["options"]["version"] = 0.2

default["netdata"]["options"]["source"] = "https://github.com/ktsaou/netdata/archive/v#{node["netdata"]["options"]["version"]}.tar.gz"

default["netdata"]["options"]["filename"] = "/opt/netdata-v#{node["netdata"]["options"]["version"]}.tar.gz"

default["netdata"]["options"]["path"] = "/opt/netdata-#{node["netdata"]["options"]["version"]}"
