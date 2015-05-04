## YUM (RPM) Packages
default['yum-packages']['install'] = ['telnet','psmisc','screen','nano','sysstat','lsof','less','vim','strace','bzip2','gzip','dstat','iotop','rsync','bind-utils']
default['yum-packages']['upgrade'] = []
default['yum-packages']['remove']  = []

default['pip']['index_url']           = 'https://pypi.python.org/simple/'
default['pip']['extra_index_url']     = nil # Set this within an environment if you are running your own pypi-server
default['pip']['packages']['install'] = []
default['pip']['packages']['upgrade'] = []
default['pip']['packages']['remove']  = []
