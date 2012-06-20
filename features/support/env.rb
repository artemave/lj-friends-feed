Bundler.require :default, :test

$: << File.expand_path('../../../lib', __FILE__)
require 'lj-friends-feed/models/feed'

FactoryGirl.find_definitions

World(FactoryGirl::Syntax::Methods)
