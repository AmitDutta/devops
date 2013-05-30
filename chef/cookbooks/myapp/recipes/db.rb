include_recipe 'mysql::ruby'
#include_recipe "iptables"

#iptables_rule "port_mysql" do
#  cookbook "mysql"
#end
 
#iptables_rule "port_ssh" do
#  cookbook "openssh"
#end

mysql_connection_info = {
  :host => "localhost",
  :username => 'root',
  :password => node['mysql']['server_root_password']
}


mysql_database node['myapp']['database']['name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['myapp']['database']['user'] do
  connection mysql_connection_info
  password node['myapp']['database']['password']
  database_name node['myapp']['database']['name']
  host '%'
  action :grant
    
  #tmpdirname = "temp145785454"  
  #cmd = "rm -rf /tmp/#{tmpdirname}"
  #value = %x[ #{cmd} ]
  #cmd = "mkdir /tmp/#{tmpdirname}"
  #value = %x[ #{cmd} ]
  #cmd = "git clone #{node['myapp']['website']['sources']} /tmp/#{tmpdirname}"
  #value = %x[ #{cmd} ]  
  #cmd =  "mysql -u#{node['myapp']['database']['user']} -p#{node['myapp']['database']['password']} -D #{node['myapp']['database']['name']} -h #{node['mysql']['bind_address']} < /tmp/#{tmpdirname}/#{node['myapp']['website']['dbpath']}"  
  #value = %x[ #{cmd} ]  
end

local_file = "tmp/master.zip"

remote_file local_file do 
 source "https://github.com/AmitDutta/my-website/archive/master.zip"
 user "vagrant"
 mode "0777"
 group "vagrant"
 action :create
end

execute "unzip-site" do
 user "vagrant"
 cwd "/tmp"
 command "unzip -o master.zip" 
 action :run
end

execute "load-db" do
 user "vagrant"
 group "vagrant"
 command "mysql -u#{node['myapp']['database']['user']} -p#{node['myapp']['database']['password']} -D #{node['myapp']['database']['name']} -h #{node['mysql']['bind_address']} < /tmp/my-website-master/#{node['myapp']['website']['dbpath']}"  
 action :run
end

#~ mysql_database "run script" do
  #~ connection mysql_connection_info
  #~ sql { ::File.open("/tmp/my-website-master/#{node['myapp']['website']['dbpath']}").read }
  #~ action :query
#~ end

execute "remove-zip" do 
 user "vagrant"
 group "vagrant"
 cwd "/tmp"
 command "rm master.zip" 
 action :run
end

execute "remove_site_dir" do 
 user "vagrant" 
 group "vagrant"
 cwd "/tmp"
 command "rm -rf my-website-master/"
 action :run
end
