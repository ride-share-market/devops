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

# include_recipe "docker-relk::install"
#
# include_recipe "docker-relk::configure_rabbitmq"
#
# include_recipe "docker-relk::configure_elasticsearch"
#
# include_recipe "docker-relk::configure_lumberjack"
#
include_recipe "docker-relk::configure_logstash"
#
# include_recipe "docker-relk::configure_kibana"
#
include_recipe "docker-relk::rsyslog"
