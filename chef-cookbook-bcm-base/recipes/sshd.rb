#
# Cookbook Name:: bcm-base
# Recipe:: sshd
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package "openssh-server" do
    action :install
end

template "/etc/ssh/sshd_config" do
        source "sshd_config.erb"
        mode 0644
        owner "root"
        group "root"
        notifies :restart, "service[sshd]", :delayed
end

service "sshd" do
        supports :restart => true, :reload => true
        action [ :enable, :start ]
end

