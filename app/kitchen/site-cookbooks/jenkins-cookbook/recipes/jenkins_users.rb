# It seems the password does not update on re-run.
# To ensure password is always updated and current first remove the user
jenkins_user 'rsmadmin' do
  action :delete
end

# Create a Jenkins user with specific attributes
jenkins_user "rsmadmin" do
  full_name   "RSM Admin"
  email       "systemsadmin@ridesharemarket.com"
  password    node["secrets"]["data"]['jenkins']['users']['rsmadmin']['password']
end