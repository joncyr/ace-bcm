#
# Cookbook Name:: bcm-accounts
# Recipe:: sudo
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Instruct sudo cookbook to include /etc/sudoers.d/*
node.default['authorization']['sudo']['include_sudoers_d'] = true

# Configure /etc/sudoers
include_recipe "sudo"

# Sudo access for groups
node['accounts']['sudo']['groups'].each do |sudo_group|
    grp_name   = sudo_group['name']
    grp_runas  = sudo_group['runas']    or 'ALL'
    grp_cmds   = sudo_group['commands'] or ['ALL']

    if sudo_group['nopass'].nil? then
      grp_nopass = true
    else
      grp_nopass = sudo_group['nopass']
    end

    sudo grp_name do
      group    grp_name
      runas    grp_runas
      nopasswd grp_nopass
      commands grp_cmds
    end
end

# Sudo access for users
node['accounts']['sudo']['users'].each do |sudo_user|
    usr_name   = sudo_user['name']
    usr_runas  = sudo_user['runas']    or 'ALL'
    usr_cmds   = sudo_user['commands'] or ['ALL']

    if sudo_user['nopass'].nil? then
      usr_nopass = true
    else
      usr_nopass = sudo_user['nopass']
    end

    sudo usr_name do
      user     usr_name
      runas    usr_runas
      nopasswd usr_nopass
      commands usr_cmds
    end
end

