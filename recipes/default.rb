#
# Cookbook Name:: auth
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if platform?("redhat", "centos", "fedora")

  remote_file "#{Chef::Config[:file_cache_path]}/epel-release.noarch.rpm" do
    source "http://dl.fedoraproject.org/pub/epel/#{node[:platform_version].to_i}/#{node[:kernel][:machine]}/epel-release-#{node[:platform_version].to_i}-8.noarch.rpm"
  end

  package "epel-release" do
    action :install
    source "#{Chef::Config[:file_cache_path]}/epel-release.noarch.rpm"
    provider Chef::Provider::Package::Rpm
  end

  node['zabbix-server-misc']['packages']['rhel'].each do |pkg|
    package "#{pkg}" do
      action :install
    end
  end

  cookbook_file "#{Chef::Config[:file_cache_path]}/ruby-1.9.3p385-2.el6.x86_64.rpm" do
    source "ruby-1.9.3p385-2.el6.x86_64.rpm"
  end

  package "ruby" do
    action :install
    source "#{Chef::Config[:file_cache_path]}/ruby-1.9.3p385-2.el6.x86_64.rpm"
    provider Chef::Provider::Package::Rpm
  end

  node['zabbix-server-misc']['packages']['gem'].each do |pkg|
    gem_package "#{pkg}" do
      action :install
      options("--no-ri --no-rdoc")
    end
  end

  template "/usr/lib64/ruby/gems/1.9.1/gems/zbxapi-0.2.415/zbxapi.rb" do
    source "zbxapi.rb.erb"
    mode "00644"
    owner "root"
    group "root"
  end

  template "/usr/lib64/ruby/gems/1.9.1/gems/zbxapi-0.2.415/api_classes/dsl_host.rb" do
    source "dsl_host.rb.erb"
    mode "00644"
    owner "root"
    group "root"
  end

  service "udev-post" do
    action [ :disable, :stop ]
  end

  service "avahi-daemon" do
    action [ :disable, :stop ]
  end

  service "iptables" do
    supports :status => true, :restart => true, :reload => true
    action [ :disable, :stop ]
  end

  service "ip6tables" do
    supports :status => true, :restart => true, :reload => true
    action [ :disable, :stop ]
  end
end


if platform?("ubuntu")
  node['zabbix-server-misc']['packages']['ubuntu'].each do |pkg|
    package "#{pkg}" do
      action :install
    end
  end

  node['zabbix-server-misc']['packages']['gem'].each do |pkg|
    gem_package "#{pkg}" do
      action :install
      options("--no-ri --no-rdoc")
    end
  end
end



template "/etc/zabbix/rbvmoni-zabbix.rb" do
  source "rbvmoni-zabbix.rb.erb"
  mode "00755"
  owner "root"
  group "root"
end

template "/etc/zabbix/zabbix_agentd.d/userparameter_vsphere-vm.conf" do
  source "userparameter_vsphere-vm.conf.erb"
  mode "00644"
  owner "root"
  group "root"
end

template "/usr/lib/zabbix/externalscripts/esxi-status.rb" do
  source "esxi-status.rb.erb"
  mode "00755"
  owner "root"
  group "root"
end

# template "/etc/ntp.conf" do
#   source "ntp.conf.erb"
#   notifies :restart, "service[#{node['ntp']['service']}]"
# end

# service node['ntp']['service'] do
#   action [:enable, :start]
# end


service "monit" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/monit.conf" do
  source "monit.conf.erb"
  mode "00600"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/httpd" do
  source "httpd.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/httpd" do
  source "httpd.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/httpd" do
  source "httpd.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/logging" do
  source "logging.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/mail" do
  source "mail.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/postgres" do
  source "postgres.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/snmptrapd" do
  source "snmptrapd.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/zabbix-server" do
  source "zabbix-server.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end

template "/etc/monit.d/zabbix-agent" do
  source "zabbix-agent.erb"
  mode "00644"
  owner "root"
  group "root"
  notifies :restart, "service[monit]"
end


# template "/etc/zabbix/zabbix_agentd.conf" do
#   source "zabbix_agentd.conf.erb"
#   action :create
#   mode 0644
#   notifies :restart, "service[zabbix-agent]"
# end

# service "zabbix-agent" do
#   supports :status => true, :restart => true, :reload => true
#   action [ :enable, :start ]
# end

