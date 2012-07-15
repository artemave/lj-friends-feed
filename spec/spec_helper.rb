require 'factory_girl'
require 'rspec'
require 'faker'
require 'awesome_print'

Dir[File.expand_path '../matchers/*.rb', __FILE__].each &method(:require)

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
