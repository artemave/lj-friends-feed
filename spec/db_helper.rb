require 'mongoid'
require 'rspec'
require 'database_cleaner'

ENV['MONGOID_ENV'] = 'test'
Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.orm = "mongoid"

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.clean
  end
end
