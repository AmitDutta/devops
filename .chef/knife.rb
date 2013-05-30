current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "amitdutta"
client_key               "#{current_dir}/amitdutta.pem"
validation_client_name   "amit-personal-validator"
validation_key           "#{current_dir}/amit-personal-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/amit-personal"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../chef/cookbooks"]
