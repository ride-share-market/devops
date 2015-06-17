default['docker']['restart'] = nil
# default['docker']['options'] = "--insecure-registry #{node["network"]["interfaces"]["eth1"]["addresses"].keys[1]}:5000"
default['docker']['options'] = "--insecure-registry reg01.dev.vbx.ridesharemarket.com:5000"
