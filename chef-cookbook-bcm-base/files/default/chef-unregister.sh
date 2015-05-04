#!/bin/bash

# Script is used by systems who wish to unregister themselves from
# their Chef server upon shutdown. This is useful for auto-scaling ephemeral
# instances that may and will dis/appear at various intervals.

# Extract node name from chef's client.rb. We do this instead of just using
# a callout to $(hostname -f) as there may be a situation where the node
# name has been changed (for some reason).
NODENAME=$(/usr/bin/grep node_name /etc/chef/client.rb | /usr/bin/awk '{print $2}' | /usr/bin/sed -e 's/\"//g')

# Delete the node from the Chef server
/usr/bin/knife node delete ${NODENAME} -c /etc/chef/client.rb -y

# Delete the client key from the Chef server
/usr/bin/knife client delete ${NODENAME} -c /etc/chef/client.rb -y

# Purge the chef client key from the local system
/usr/bin/rm /etc/chef/client.pem -f
