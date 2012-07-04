require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require_relative 'feed'
require_relative 'feed_populator'

set :root, File.expand_path('../..', __FILE__)

get '/' do
  haml :index
end

post '/feeds' do
  # TODO empty username
  # TODO non existent lj user
  # TODO feed alreay exists

  feed = Feed.new username: params['username']
  FeedPopulator.new.populate feed
end
