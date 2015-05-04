#
# Cookbook Name:: bcm-base
# Recipe:: mirrorlist
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Hack workaround because cannot set nil values in
# environment/role for settings.  They get overridden
# during chef deep merge by defaults elsewhere.

node.default['yum']['base']['mirrorlist']       = nil
node.default['yum']['updates']['mirrorlist']    = nil
node.default['yum']['extras']['mirrorlist']     = nil
node.default['yum']['centosplus']['mirrorlist'] = nil
node.default['yum']['epel']['mirrorlist']       = nil
