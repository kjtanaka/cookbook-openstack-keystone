#
# Cookbook Name:: openstack-keystone
# Recipe:: install
#
# Copyright 2014, FutureGrid, Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

secrets = Chef::EncryptedDataBagItem.load("openstack", "secrets")

openstack_mysql_user = secrets['mysql_user']
openstack_mysql_password = secrets['mysql_password']
openstack_admin_token = secrets['admin_token']
openstack_admin_password = secrets['admin_password']
openstack_service_password = secrets['service_password']
openstack_mysql_host = node["openstack"]["admin_address"]
keystone_db = "keystone"
openstack_public_address = node["openstack"]["public_address"]
openstack_internal_address = node["openstack"]["internal_address"]
openstack_admin_address = node["openstack"]["admin_address"]

package "keystone" do
	action :install
end

template "/etc/keystone/keystone.conf" do
  source "keystone.conf.erb"
  mode "0644"
  owner "root"
  group "root"
  action :create
  variables(
    :openstack_mysql_password => openstack_mysql_password,
    :openstack_mysql_user => openstack_mysql_user,
    :keystone_db => keystone_db,
    :openstack_mysql_host => openstack_mysql_host,
    :admin_token => openstack_admin_token
  )
  notifies :restart, "service[keystone]", :immediately
end

execute "keystone_manage_db_sync" do
  command "keystone-manage db_sync && touch /etc/keystone/.db_synced_do_not_delete"
  creates "/etc/keystone/.db_synced_do_not_delete"
  action :run
  notifies :restart, "service[keystone]"
end

service "keystone" do
  supports :restart => true
  restart_command "restart keystone"
  action :nothing
end

service "mysql" do
  supports :restart => true
  action :nothing
end

template "/root/admin_credential" do
  source "admin_credential.erb"
  mode "0600"
  owner "root"
  group "root"
  action :create
  variables(
    :openstack_admin_password => openstack_admin_password,
    :openstack_admin_address => openstack_admin_address
	)
end

template "/root/sample_data.sh" do
  source "sample_data.sh.erb"
  mode "0600"
  owner "root"
  group "root"
  action :create
  variables(
    :openstack_admin_password => openstack_admin_password,
    :openstack_service_password => openstack_service_password,
    :openstack_admin_address => openstack_admin_address,
    :openstack_internal_address => openstack_internal_address,
    :openstack_public_address => openstack_public_address
	)
	notifies :restart, "service[mysql]", :immediately
  notifies :run, "execute[init_keystone_data]", :immediately
end

execute "init_keystone_data" do
  command "bash /root/sample_data.sh && touch /etc/keystone/.init_keystone_data_do_not_delete"
  creates "/etc/keystone/.init_keystone_data_do_not_delete"
  action :nothing
end
