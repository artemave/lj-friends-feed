Bundler.require :default, :test

require 'rss'
require 'factory_girl'
require 'capybara/cucumber'

require_relative 'ui_helpers'

[
  File.expand_path('../../../spec/matchers/*.rb', __FILE__),
  File.expand_path('../../../lib/*.rb', __FILE__)
].each do |glob|
  Dir[glob].each &method(:require)
end

World(FactoryGirl::Syntax::Methods, UiHelpers)

Capybara.app = Sinatra::Application

FactoryGirl.find_definitions
