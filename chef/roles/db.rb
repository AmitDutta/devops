name "db"
description "Database Server Role"
run_list( 
  "recipe[unzip]",     
  "recipe[mysql::server]",
  "recipe[database::mysql]",
  "recipe[myapp::db]"
)
