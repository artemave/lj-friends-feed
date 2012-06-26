Bundler.require :default, :test
require 'factory_girl'

Dir[File.expand_path '../../lib/*.rb', __FILE__].each &method(:require)

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
