#
# Cookbook Name:: docker-relk
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "secrets::default"

raise "Missing required rabbitmq secrets: enabled_users" if !node["secrets"]["data"]["rabbitmq"]["enabledUsers"]

include_recipe "docker-relk::rabbitmq"

include_recipe "docker-relk::elasticsearch"

include_recipe "docker-relk::logstash"

include_recipe "docker-relk::kibana"

include_recipe "docker-relk::lumberjack"

include_recipe "docker-relk::rsyslog"