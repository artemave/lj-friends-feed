Bundler.require :default, :test
require 'rss'
require_relative '../../spec/matchers/feed_matchers'

$: << File.expand_path('../../../lib', __FILE__)
require 'lj-friends-feed/models/feed'
