#
# Cookbook Name:: bcm-base
# Recipe:: packages
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

################################################################################
# Base set of packages via YUM
################################################################################

node['yum-packages']['install'].each do |pkg|
    package pkg do
        action :install
    end
end

node['yum-packages']['upgrade'].each do |pkg|
    package pkg do
        action :upgrade
    end
end

node['yum-packages']['remove'].each do |pkg|
    package pkg do
        action :remove
    end
end

################################################################################
# Install any python packages defined by attributes via PIP
################################################################################
include_recipe "bcm-base::pip"

node['pip']['packages']['install'].each do |pip_install_pkg|
  python_pip pip_install_pkg do
    action :install
    environment ({ 'PIP_CONFIG_FILE' => '/etc/pip.conf' })
  end
end

node['pip']['packages']['upgrade'].each do |pip_upgrade_pkg|
  python_pip pip_upgrade_pkg do
    action :upgrade
    environment ({ 'PIP_CONFIG_FILE' => '/etc/pip.conf' })
  end
end

node['pip']['packages']['remove'].each do |pip_remove_pkg|
  python_pip pip_remove_pkg do
    action :remove
    environment ({ 'PIP_CONFIG_FILE' => '/etc/pip.conf' })
  end
end
