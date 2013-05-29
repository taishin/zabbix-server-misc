default['zabbix-server-misc']['packages']['rhel'] = %w{
  system-config-network-tui
  make
  gcc
  kernel-devel
  perl
  mlocate
  telnet
  bind-utils
  tcpdump
  vim-enhanced
  git
  zsh
  screen
  pkgconfig
  libyaml
  libxml2
  libxml2-devel
  libxslt
  libxslt-devel
}
default['zabbix-server-misc']['packages']['ubuntu'] = %w{ 
  mlocate
  telnet
  dnsutils
  tcpdump
  vim
  git
  zsh
  screen
  ruby1.9.3
}
default['zabbix-server-misc']['packages']['gem'] = %w{
  nokogiri
  zbxapi
  rbvmomi
  thinreports
}
