require 'bundler'
Bundler.require(:default)

$:<< './lib'
require 'frontend'
run Frontend.new
