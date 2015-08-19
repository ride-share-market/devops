#
# Cookbook Name:: docker-couchbase
# Recipe:: default
#
# Copyright (C) 2015 Ride Share Market
#
# All rights reserved - Do Not Redistribute
#
include_recipe "secrets::default"

raise "Missing required couchbase secrets." if !node["secrets"]["data"]["couchbase"]

include_recipe "docker-couchbase::install"

include_recipe "docker-couchbase::configure"
