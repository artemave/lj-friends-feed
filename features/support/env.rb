Bundler.require :default, :test

require 'rss'
require 'factory_girl'
require_relative '../../spec/matchers/feed_matchers'

Dir[File.expand_path '../../../lib/*.rb', __FILE__].each &method(:require)

World(FactoryGirl::Syntax::Methods)

FactoryGirl.find_definitions
