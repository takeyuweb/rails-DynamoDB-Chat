# load the libraries
require 'aws'
# log requests using the default rails logger
AWS.config(logger: Rails.logger,
           log_level: :info)
# load credentials from a file
config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
AWS.config(YAML.load(File.read(config_path)))
Dynamoid.configure do |config|
  config.adapter = 'aws_sdk' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
  config.namespace = "DynamoChat-#{Rails.env}" # To namespace tables created by Dynamoid from other tables you might have.
  config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
  config.partitioning = false
  config.read_capacity = 2
  config.write_capacity = 1
end
