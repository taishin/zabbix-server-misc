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
  monit
  wget
  zip
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
  monit
}
default['zabbix-server-misc']['packages']['gem'] = %w{
  nokogiri
  zbxapi
  rbvmomi
  thinreports
  zipruby
}
default['ntp']['servers'] = %w{ntp.nict.jp}
case platform
  when "redhat", "centos", "fedora"
    default['ntp']['service'] = "ntpd"
  when "ubuntu"
    default['ntp']['service'] = "ntp"
end

default['zabbix-server-misc']['monit']['mailserver'] = "localhost"
default['zabbix-server-misc']['monit']['fromaddress'] = "from@example.com"
default['zabbix-server-misc']['monit']['toaddress'] = %w{
  test1@example.com
  test2@example.com
}
default['zabbix-server-misc']['zabbix-agent']['hostname'] = "localhost"
