default['accounts']['groups_databag'] = 'groups'
default['accounts']['users_databag']  = 'users'

default['accounts']['groups'] = []
default['accounts']['users']  = []

default['accounts']['sudo']['users']  = []
default['accounts']['sudo']['groups'] = []

default['authorization']['sudo']['sudoers_defaults'] = [
    'requiretty',
    '!visiblepw',
    'always_set_home',
    'env_reset',
    'env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"',
    'env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"',
    'env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"',
    'env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"',
    'env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"',
    'secure_path = /sbin:/bin:/usr/sbin:/usr/bin'
]

default['authorization']['sudo']['command_aliases'] = [
  { 'name' => 'NETWORKING',
    'command_list' => [ 
      '/sbin/route',
      '/sbin/ifconfig',
      '/bin/ping',
      '/sbin/dhclient',
      '/usr/bin/net',
      '/sbin/iptables',
      '/usr/bin/rfcomm',
      '/usr/bin/wvdial',
      '/sbin/iwconfig',
      '/sbin/mii-tool'
    ]
  },
  { 'name' => 'SOFTWARE',
    'command_list' => [
      '/bin/rpm',
      '/usr/bin/up2date',
      '/usr/bin/yum'
    ]
  },
  { 'name' => 'SERVICES',
    'command_list' => [
      '/sbin/service',
      '/sbin/chkconfig'
    ]
  },
  { 'name' => 'LOCATE',
    'command_list' => [
      '/usr/bin/updatedb'
    ]
  },
  { 'name' => 'STORAGE',
    'command_list' => [
      '/sbin/fdisk',
      '/sbin/sfdisk',
      '/sbin/parted',
      '/sbin/partprobe',
      '/bin/mount',
      '/bin/umount'
    ]
  },
  { 'name' => 'DELEGATING',
    'command_list' => [
      '/usr/sbin/visudo',
      '/bin/chown',
      '/bin/chmod',
      '/bin/chgrp'
    ]
  },
  { 'name' => 'PROCESSES',
    'command_list' => [
      '/bin/nice',
      '/bin/kill',
      '/usr/bin/kill',
      '/usr/bin/killall'
    ]
  },
  { 'name' => 'DRIVERS',
    'command_list' => [
      '/sbin/modprobe'
    ]
  }
]
