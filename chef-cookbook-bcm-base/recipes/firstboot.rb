#
# Cookbook Name:: bcm-base
# Recipe:: firstboot
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# cloud-init will write a run list to the file
# /etc/chef/firstboot.json, which is referenced within
# /etc/chef/client.rb by the line:
# json_attribs           "/etc/chef/firstboot.json"
# Anything in firstboot.json, including run lists,
# will override settings on the upstream chef server.
# We need to clean this file out in order to be able
# to manage nodes via upstream chef server and not
# just what was set in user-data fed to cloud-init on
# the instance's first bootup.

execute "clean /etc/chef/firstboot.json" do
  command 'echo {} > /etc/chef/firstboot.json'
end
