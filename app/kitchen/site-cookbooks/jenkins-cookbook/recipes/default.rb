#
# Cookbook Name:: jenkins-cookbook
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
# include_recipe "jenkins::master"
#
# jenkins_plugin "greenballs"
# jenkins_plugin "git"

# include_recipe "jenkins-cookbook::jenkins_job_app"
# include_recipe "jenkins-cookbook::jenkins_job_data"
# include_recipe "jenkins-cookbook::jenkins_job_docker"

include_recipe "jenkins-cookbook::jenkins_jobs"
