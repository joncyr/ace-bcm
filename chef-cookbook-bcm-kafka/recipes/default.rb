#
# Cookbook Name:: bcm-kafka
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

# Install Kafka (via BCM provided package)
package "kafka" do
  action :install
  version node['kafka']['version']
end

# Create logs directory and set permissions
directory node['kafka']['logs_dir'] do
  owner  node['kafka']['user']
  group  node['kafka']['group']
  mode   '0755'
  action :create
end

# Configure the broker log4j settings
template '/etc/kafka/log4j.properties' do
  source "log4j.properties.erb"
  owner 'root'
  group 'root'
  mode 0644
  variables ({
    :c => node['kafka']
  })
  notifies :restart, 'service[kafka]', :delayed
end

# Write our own custom environment file
template '/etc/kafka/kafka-env.sh' do
  source "kafka-env.sh.erb"
  owner  "root"
  group  "root"
  mode   0755
  variables ({
    :c => node['kafka']
  })
end
