require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require_relative 'feed_persistence_service'

set :root, File.expand_path('../..', __FILE__)

get '/' do
  haml :index
end

get '/feeds/:username' do |username|
  @feed = FeedPersistenceService.find(username)
  haml :show
end

post '/feeds' do
  # TODO empty username
  # TODO non existent lj user
  # TODO feed alreay exists

  # feed = Feed.new username: params['username']
  # FeedPopulator.new.populate feed

  feed = FeedPersistenceService.find_or_create(params['username'])
  redirect "/feeds/#{feed.username}"
end
