#
# Cookbook Name:: bcm-kafka
# Recipe:: broker
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "bcm-kafka::default"

# Configure the broker settings
template '/etc/kafka/server.properties' do
  source "server.properties.erb"
  owner 'root'
  group 'root'
  mode 0644
  variables ({
    :c => node['kafka']
  })
  notifies :restart, 'service[kafka]', :delayed
end

template '/etc/sysconfig/kafka' do
  source "kafka-sysconfig.erb"
  owner 'root'
  group 'root'
  mode 0644
  variables ({
    :c => node['kafka']
  })
  notifies :restart, 'service[kafka]', :delayed
end

# Enable and start the Kafka Broker
service 'kafka' do
  supports :restart => true, :status => true
  action [ :enable, :start ]
end
