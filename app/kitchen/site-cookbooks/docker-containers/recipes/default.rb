#
# Cookbook Name:: docker-containers
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "docker-containers::rsm_docker_scripts"
include_recipe "docker-containers::rsm_registry"
include_recipe "docker-containers::rsm_registry_ui"
