# to see things in docker logs
STDOUT.sync = true
STDERR.sync = true

require 'bundler'
Bundler.require(:default)

$:<< './lib'
require 'frontend'
run Frontend.new
