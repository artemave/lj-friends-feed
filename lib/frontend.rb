require 'sinatra'
require 'haml'

set :root, File.expand_path('../..', __FILE__)

get '/' do
  haml :index
end

post '/feeds' do
  # TODO empty username
  # TODO non existent lj user
  # TODO feed alreay exists
  feed = Feed.new username: params['username']
  feed.populate
end
