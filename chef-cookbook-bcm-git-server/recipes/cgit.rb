#
# Cookbook Name:: bcm-git-server
# Recipe:: cgit
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

packages = %w{
  cgit
  httpd
  highlight
}

packages.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/cgitrc" do
  source "cgitrc.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

node.default['apache']['listen_addresses'] = [ '0.0.0.0' ]

include_recipe "apache2"
include_recipe "apache2::mod_cgi"

web_app "cgit" do
  server_name node['git']['server_name']
  template "cgit.conf.erb"
end
