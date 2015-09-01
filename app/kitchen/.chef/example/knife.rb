knife[:berkshelf_path] = "cookbooks"

cookbook_path    ["berks-cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "berks-cookbooks"

knife[:aws_access_key_id] = "#{ENV['AWS_ACCESS_KEY']}"
knife[:aws_secret_access_key] = "#{ENV['AWS_SECRET_KEY']}"

knife[:digital_ocean_access_token] = "#{ENV['RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN']}"

# https://manage.chef.io/organizations/*******
log_level :info
log_location STDOUT
node_name "**********"
client_key "**********"
validation_client_name "**********"
validation_key "**********"
chef_server_url "**********"
syntax_check_cache_path "**********"
