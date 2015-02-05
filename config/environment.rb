# Load the Rails application.
require File.expand_path('../application', __FILE__)

APP_CONFIG_FILE = Rails.root.join("config","application.yml")

# Initialize the Rails application.
Rails.application.initialize!
