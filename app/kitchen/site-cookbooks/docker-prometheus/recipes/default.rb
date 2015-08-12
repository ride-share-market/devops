#
# Cookbook Name:: docker-prometheus
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "docker-prometheus::node-exporter"
include_recipe "docker-prometheus::container-exporter"
include_recipe "docker-prometheus::statsd-bridge"
include_recipe "docker-prometheus::prometheus"
