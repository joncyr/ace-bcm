#
# Cookbook Name:: bcm-base
# Recipe:: pip
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Configures system to use local pip mirror

template "/etc/pip.conf" do
  source "pip.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables ({
    :p => node['pip']
  })
end

cookbook_file "/etc/profile.d/pip.sh" do
  source "profile.d-pip.sh"
  owner  "root"
  group  "root"
  mode   "0644"
end

package "python-pip" do
  action :install
end
