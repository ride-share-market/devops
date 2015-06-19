#
# Cookbook Name:: jenkins-cookbook
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "jenkins::master"

include_recipe "secrets::default"

raise "Missing required Jenkins Private Key" if !node["secrets"]["data"]['jenkins']['users']['chef']['privateKey']

# Create the Jenkins user with the public key
jenkins_user 'chef' do
  public_keys [node["secrets"]["data"]['jenkins']['users']['chef']['publicKey']]
end

# Set the private key on the Jenkins executor
node.run_state[:jenkins_private_key] = node["secrets"]["data"]['jenkins']['users']['chef']['privateKey']

jenkins_plugin "greenballs"
jenkins_plugin "git"

include_recipe "jenkins-cookbook::jenkins_users"

include_recipe "jenkins-cookbook::jenkins_jobs"
