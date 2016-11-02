#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

######################################################################################################
###                                                                                                ###
### This script performs the following steps:                                                      ###
###                                                                                                ###
### 1. Install OS packages:                                                                        ###
###     apt-get install -y --allow-unauthenticated libapache2-mod-wsgi python-pip python-mysqldb   ###

package 'libapache2-mod-wsgi' do
  action :install
end

package 'python-mysqldb' do
  action :install
end

package 'python-pip' do
  action :install
end

### 2. Install python package:                                                                     ###
###     pip install flask


execute "run_flask_install" do
  command "pip install flask"
  action :run
end

                                                                    ###
### 3. Stop apache                                                                                 ###
###     apachectl stop                                                                             ###
service 'apache2' do
  action [:stop]
end

### 4. Write /etc/apache2/sites-enabled/AAR-apache.conf                                            ###
###      contents marked in the code below                                                         ###

cookbook_file '/etc/apache2/sites-enabled/AAR-apache.conf' do
  action :create
  owner 'root'
  group 'root'
end

	
### 5. Write /var/www/AAR/AAR_config.py                                                            ###
###      contents marked in the code below 
%w[ /var /var/www  /var/www/AAR ].each do |path|
  directory path do
  action :create
    owner 'www-data'
    group 'www-data'
    mode '0755'
  end
end                                                        ###
cookbook_file '/var/www/AAR/AAR_config.py' do
  action :create
  owner 'www-data'
  group 'www-data'
end

### 6. Run mysql script                                                                            ###
###      mysql -proot < make_AARdb.sql                                                             ###
cookbook_file "/tmp/make_AARdb.sql" do
  source "make_AARdb.sql"
  mode 0755
end
execute "run_my_sql_script" do
  command "mysql -proot < /tmp/make_AARdb.sql "
  action :run
end

### 7. Create mysql user                                                                           ###
###      mysql -proot -e "CREATE USER 'aarapp'@'localhost' IDENTIFIED BY '7ERwzg7E'"               ###
execute "create_my_sql_user" do
  command "mysql -proot -e \"CREATE USER 'aarapp'@'localhost' IDENTIFIED BY '7ERwzg7E'\""
  action :run
end
### 8. Grant mysql user permissions                                                                ###
###      mysql -proot -e "GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to aarapp@localhost" ###
execute "create_my_sql_user" do
  command "mysql -proot -e \"GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to aarapp@localhost\""
  action :run
end
### 9. Start apache                                                                                ###
###      apachectl start                                                                          ###
service 'apache2' do
  action [:start]
end
###                                                                                                ###
######################################################################################################

