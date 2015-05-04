#
# Cookbook Name:: bcm-feeds
# Recipe:: server
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

################################################################################
# Install RPM Packages on Feeds Server (YUM)
################################################################################
yum_packages = %w{
  ruby
  perl
  git
  unzip
  bzip2
  python-devel
  postgresql94-server
  postgresql94-contrib
  python-psycopg2
  mariadb-server
  mariadb-devel
  MySQL-python
  gcc
  gcc-c++
}

yum_packages.each do |yum_pkg|
  package yum_pkg do
    action :install
  end
end

################################################################################
# Install Python Packages on Feeds Server (PIP)
################################################################################
include_recipe "bcm-base::pip"

pip_packages = %w{
  py-mysql2pgsql
  sqlalchemy
  mock
  fabric
}

pip_packages.each do |pip_pkg|
  python_pip pip_pkg do
    action :install
    environment ({ 'PIP_CONFIG_FILE' => '/etc/pip.conf' })
  end
end

################################################################################
# Install Ruby Packages on Feeds Server (GEM)
################################################################################
gem_packages = %w{
  oauth
}

gem_packages.each do |gem_pkg|
  gem_package gem_pkg do
    action :install
  end
end

################################################################################
# Initialize Databases
################################################################################
execute "/usr/pgsql-9.4/bin/initdb" do
  user  "postgres"
  group "postgres"
  cwd   "/var/lib/pgsql"
  environment ({
    "HOME"   => "/var/lib/pgsql",
    "PGDATA" => "/var/lib/pgsql/9.4/data",
    "USER"   => "postgres"
  })
  not_if { ::File.exist?('/var/lib/pgsql/9.4/data/base') }
end

################################################################################
# Feeds Subsystem Logs Directory
################################################################################
directory "/var/log/feeds" do
  user   "bcmfeeds"
  group  "bcmfeeds"
  mode   "0755"
  action :create
end

################################################################################
# Enable Services
################################################################################
service "postgresql-9.4" do
  action [ :enable, :start ]
  supports :restart => true, :reload => true, :status => true
end

service "mariadb" do
  action [ :enable, :start ]
  supports :restart => true, :reload => true, :status => true
end
