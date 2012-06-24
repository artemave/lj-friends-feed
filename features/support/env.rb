Bundler.require :default, :test
require 'rss'
require_relative '../../spec/matchers/feed_matchers'

Dir[File.expand_path '../../../lib/*.rb', __FILE__].each &method(:require)
