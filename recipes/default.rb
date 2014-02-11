#
# Cookbook Name:: hamyproxy
# Recipe:: default
#
# Copyright 2014, Corsis
# http://www.corsis.com/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# cron is required for the ip tester
include_recipe "cron"

# mysql is required for haproxy's mysql-check
package "mysql-client"

# use the provider to configure the mysql proxy
haproxy_lb "mysql-cluster" do
    bind '127.0.0.1:3306'
    balance 'roundrobin'
    mode 'tcp'
    servers (
        # create the server lines
        node['hamyproxy']['servers'].map { |serverid, servername|
            "#{serverid} #{servername} check"
        }
    ).collect{|i|i} # must return array, not enum
    params([
        'option tcplog',
        'option mysql-check user haproxy_check'
    ])
end

# setup the ip tester dirs
%w[bin state].each do |subdir|
    directory "#{node['hamyproxy']['basedir']}/#{subdir}" do
        owner "root"
        group "root"
        mode 00755
        recursive true
        action :create
    end
end

# install the ip tester script
template "#{node['hamyproxy']['basedir']}/bin/hamyproxy-test" do
    source "hamyproxy-test.erb"
    owner "root"
    group "root"
    mode 00755
    variables ({
        :stateDirectory => "#{node['hamyproxy']['basedir']}/state",
        :serverNames => node['hamyproxy']['servers'],
    })
    action :create
end

# invoke the ip tester every minute
cron_d "hamyproxy-test" do
    command "#{node['hamyproxy']['basedir']}/bin/hamyproxy-test 2>&1 >/dev/null"
    user "root"
end

# finally, install haproxy
include_recipe "haproxy"
