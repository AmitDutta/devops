name "web"
description "Web Server Role"
run_list(
  "recipe[openssh]",
  "recipe[unzip]",
  "recipe[apache2]",  
  "recipe[apache2::mod_php5]",  
  "recipe[mysql::client]",  
  "recipe[xml]",
  "recipe[php]",
  "recipe[php::module_mysql]",
  "recipe[myapp::web]"
)
