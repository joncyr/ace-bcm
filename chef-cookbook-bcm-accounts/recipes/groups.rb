#
# Cookbook Name:: bcm-accounts
# Recipe:: groups
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users"

# Run users_manage on each group specified
node['accounts']['groups'].each do |grp_name|
  # Lookup the group databag entry
  grp_db = search(node['accounts']['groups_databag'], "id:#{grp_name}").first

  # Create the group and all users in that group
  users_manage grp_name do
    group_id grp_db['gid']
    data_bag node['accounts']['users_databag']
  end
end

