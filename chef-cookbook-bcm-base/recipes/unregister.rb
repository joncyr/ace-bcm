#
# Cookbook Name:: bcm-base
# Recipe:: unregister
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

##
## Recipe is used for unregistering a node and client upon shutdown. This is
## useful for autoscaling instances who configure themselves with Chef, but
## should purge themselves from their Chef server when they terminate.
##

cookbook_file "/etc/chef/chef-unregister.sh" do
  source "chef-unregister.sh"
  user   "root"
  group  "root"
  mode   "0755"
end

cookbook_file "/etc/systemd/system/chef-unregister.service" do
  source "chef-unregister.service"
  user   "root"
  group  "root"
  mode   "0644"
end

service "chef-unregister" do
        action [ :enable, :start ]
end
