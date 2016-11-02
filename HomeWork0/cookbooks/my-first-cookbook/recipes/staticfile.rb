#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'unzip' do
  action :install
  version node.default[:unzip][:version]

end

%w[ /opt /opt/opsSchool ].each do |path|
  directory path do
  action :create
    owner 'root'
    group 'root'
    mode '0755'
  end
end

#cookbook_file '/opt/opsSchool/static_file_vr.txt' do
#  action :create
#  owner 'root'
#  group 'root'
#  mode '0755'

#end

template "/opt/opsSchool/static_file_vr.txt" do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
  source "static_file_vr.txt.erb"
end



