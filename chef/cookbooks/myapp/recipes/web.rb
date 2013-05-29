include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"

apache_site "default" do
  enable false
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
 user "root"
 cwd "/tmp"
 command "unzip master.zip -d /var/www/" 
 action :run
end

web_app 'phpapp' do
  template 'site.conf.erb'
  docroot node['myapp']['website']['docroot']
  server_name node['myapp']['website']['server_name']
end
