#
# Cookbook Name:: bcm-accounts
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node['accounts']['users'].each do |user_name|

  u = search(node['accounts']['users_databag'], "id:#{user_name}").first

  ## Mostly snagged from the users cookbook:

  u['username'] ||= u['id']

  # Set home to location in data bag,
  # or a reasonable default (/home/$user).
  if u['home']
    home_dir = u['home']
  else
    home_dir = "/home/#{u['username']}"
  end

  # The user block will fail if the group does not yet exist.
  # See the -g option limitations in man 8 useradd for an explanation.
  # This should correct that without breaking functionality.
  if u['gid'] and u['gid'].kind_of?(Numeric)
    group u['username'] do
      gid u['gid']
    end
  end

  # Create user object.
  # Do NOT try to manage null home directories.
  user u['username'] do
    uid u['uid']
    if u['gid']
      gid u['gid']
    end
    if u['system'] == true
      system true
    end
    shell u['shell']
    comment u['comment']
    password u['password'] if u['password']
    if home_dir == "/dev/null"
      supports :manage_home => false
    else
      supports :manage_home => true
    end
    home home_dir
  end

  if home_dir != "/dev/null"
    directory "#{home_dir}/.ssh" do
      owner u['username']
      group u['gid'] || u['username']
      mode "0700"
    end

    if u['ssh_keys']
      template "#{home_dir}/.ssh/authorized_keys" do
        source "authorized_keys.erb"
        owner u['username']
        group u['gid'] || u['username']
        mode "0600"
        variables :ssh_keys => u['ssh_keys']
      end
    end

    if u['ssh_private_key']
      key_type = u['ssh_private_key'].include?("BEGIN RSA PRIVATE KEY") ? "rsa" : "dsa"
      template "#{home_dir}/.ssh/id_#{key_type}" do
        source "private_key.erb"
        owner u['id']
        group u['gid'] || u['id']
        mode "0400"
        variables :private_key => u['ssh_private_key']
      end
    end

    if u['ssh_public_key']
      key_type = u['ssh_public_key'].include?("ssh-rsa") ? "rsa" : "dsa"
      template "#{home_dir}/.ssh/id_#{key_type}.pub" do
        source "public_key.pub.erb"
        owner u['id']
        group u['gid'] || u['id']
        mode "0400"
        variables :public_key => u['ssh_public_key']
      end
    end
  end

end


