Bundler.require :default, :test

require 'rss'
require 'factory_girl'
require 'capybara/cucumber'
require 'rack/test'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

require_relative 'ui_helpers'

[
  File.expand_path('../../../spec/matchers/*.rb', __FILE__),
  File.expand_path('../../../lib/*.rb', __FILE__)
].each do |glob|
  Dir[glob].each &method(:require)
end

World(FactoryGirl::Syntax::Methods, Rack::Test::Methods, UiHelpers)

Capybara.app = Frontend

def app
  Frontend
end

FactoryGirl.find_definitions

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.orm = "mongoid"

Before do
  DatabaseCleaner.clean
end
