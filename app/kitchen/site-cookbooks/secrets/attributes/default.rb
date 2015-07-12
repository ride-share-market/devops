# Default env home to /root.
# Enables this recipe to run from either chef-client (no env home) and chef-solo
ENV['HOME'] = '/root' if ENV['HOME'] == nil

default["secrets"]["chef_secret_key"] = "#{ENV['HOME']}/.ssh/chef_secret_key.txt"

default["secrets"]["data"] = nil
