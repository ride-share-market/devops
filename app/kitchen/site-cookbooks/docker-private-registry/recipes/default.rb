#
# Cookbook Name:: docker-private-registry
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "docker-private-registry::registry"

include_recipe "docker-private-registry::registry_ui"
