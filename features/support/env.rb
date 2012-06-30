Bundler.require :default, :test

require 'rss'
require 'factory_girl'
require 'capybara/cucumber'

require_relative '../../spec/matchers/feed_matchers'
require_relative 'ui_helpers'

Dir[File.expand_path '../../../lib/*.rb', __FILE__].each &method(:require)

World(FactoryGirl::Syntax::Methods, UiHelpers)

Capybara.app = Sinatra::Application

FactoryGirl.find_definitions
