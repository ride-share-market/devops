#
# Cookbook Name:: docker-jenkins
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "secrets::default"

include_recipe "docker-jenkins::jobs"

include_recipe "docker-jenkins::plugins"

include_recipe "docker-jenkins::install"
