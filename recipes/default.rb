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

  template "/etc/yum.repos.d/CentOS-Base.repo" do
    source "CentOS-Base.repo.erb"
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
end

node['zabbix-server-misc']['packages']['gem'].each do |pkg|
  gem_package "#{pkg}" do
    action :install
    options("--no-ri --no-rdoc")
  end
end
