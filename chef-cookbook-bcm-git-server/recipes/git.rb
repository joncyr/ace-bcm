#
# Cookbook Name:: bcm-git-server
# Recipe:: git
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

packages = %w{
  git
}

packages.each do |pkg|
  package pkg do
    action :install
  end
end

link "/git" do
  to "/var/lib/git"
end
