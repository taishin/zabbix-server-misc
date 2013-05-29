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
  ntp
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
  ntp
}
default['zabbix-server-misc']['packages']['gem'] = %w{
  nokogiri
  zbxapi
  rbvmomi
  thinreports
}
default['ntp']['servers'] = %w{ntp.nict.jp}
case platform
  when "redhat", "centos", "fedora"
    default['ntp']['service'] = "ntpd"
  when "ubuntu"
    default['ntp']['service'] = "ntp"
end

