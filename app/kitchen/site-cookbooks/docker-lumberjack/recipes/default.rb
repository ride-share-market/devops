#
# Cookbook Name:: docker-lumberjack
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "secrets::default"

raise "Missing required: lumberjack ssl config files" if !node["secrets"]["data"]["ssl"]["lumberjack"]
