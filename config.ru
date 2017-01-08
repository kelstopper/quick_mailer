require 'bundler/setup'
require_relative './mailer_app'

require 'yaml'
$CONFIG = YAML.load_file('config/config.yml')

run Sinatra::Application
