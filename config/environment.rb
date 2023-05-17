# Load the Rails application.
require_relative "application"

#load gmail creds
gmail_creds = File.join(Rails.root, 'config', 'gmail_creds.rb')
load(gmail_creds) if File.exist?(gmail_creds)

# Initialize the Rails application.
Rails.application.initialize!
