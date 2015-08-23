# Application specific config will be kept here.
# CI builds will copy in the application config from here.
directory node["docker-jenkins"]["app_config_dir"] do
  recursive true
  owner 1000
  group 1000
end
