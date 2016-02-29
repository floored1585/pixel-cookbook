#
# Cookbook Name:: pixel
# Recipe:: default
#
# Copyright 2015, Ian Clark
# License: MIT
#

# Update repos
execute 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7'
cookbook_file '/etc/apt/sources.list.d/passenger.list' do
  mode 0600
  owner 'root'
  group 'root'
  action :create
end
execute 'apt-get update'

pkgs = [
  'libmysqlclient-dev',
  'libpq-dev',
  'nodejs',
  'nodejs-legacy',
  'npm',
  'git',
]
pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

execute 'npm install -g bower@1.5.2'

# Create pixel user
user 'pixel' do
  uid 4000
  manage_home true
  home '/home/pixel'
  shell '/bin/bash'
  action :create
end
directory '/home/pixel/.ssh' do
  owner 'pixel'
  group 'pixel'
end
cookbook_file '/home/pixel/.ssh/authorized_keys' do
  owner 'pixel'
  group 'pixel'
  action :create
  ignore_failure true # Ignores failure in case this doesn't exist in the cookbook
end


# Install RVM
node.override['rvm']['rvmrc']['rvm_autolibs_flag'] = 'disabled'
node.override['rvm']['rvmrc']['rvm_gemset_create_on_use_flag'] = 1
node.override['rvm']['user_installs'] = [{
  'user'          => 'pixel',
  'default_ruby'  => '2.2.0',
  'rubies'        => ['2.2.0']
}]
include_recipe 'rvm::user'

# Install apache
include_recipe 'apache2'

# Install passenger
package 'libapache2-mod-passenger' do
  action :install
end

# Create web app directory
dirs = [
  '/var/www/pixel',
  '/var/www/pixel/shared',
  '/var/www/pixel/shared/log',
  '/var/www/pixel/shared/config',
]
dirs.each do |dir|
  directory dir do
    owner 'pixel'
    group 'www-data'
    mode '0755'
  end
end
cookbook_file '/var/www/pixel/shared/config/config.yaml' do
  mode 0644
  owner 'pixel'
  group 'www-data'
  action :create_if_missing
  ignore_failure true # Ignores failure in case this doesn't exist in the cookbook
end
file '/var/www/pixel/shared/config/hosts.yaml' do
  mode 0644
  owner 'pixel'
  group 'www-data'
  action :create_if_missing
end
file '/var/www/pixel/shared/log/messages.log' do
  mode 0644
  owner 'pixel'
  group 'www-data'
  action :create_if_missing
end

# Add apache config
cookbook_file '/etc/apache2/sites-available/pixel.conf' do
  mode 0644
  owner 'root'
  group 'root'
  action :create
end

# Enable the site and reload apache
apache_site 'pixel' do
  enable true
end

service 'apache2' do
  action :reload
end

include_recipe 'logrotate'
logrotate_app 'pixel' do
  template_mode 0644
  path '/var/www/pixel/shared/log/messages.log'
  frequency 'daily'
  rotate 14
  create '644 root root'
end
# Stop apache from restarting when its log rotates
cookbook_file '/etc/logrotate.d/apache2' do
  mode 0644
  owner 'root'
  group 'root'
  action :create
end
