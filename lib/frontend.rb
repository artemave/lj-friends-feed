require 'sinatra/base'
require 'sinatra/reloader' if ENV['RACK_ENV'] != 'production'
require 'haml'
require 'sinatra/url_for'
require 'mongoid'
require_relative 'feed_persistence_service'
require_relative 'feed_generator'
require_relative 'link_generator'

Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)

class Frontend < Sinatra::Base
  set :root, File.expand_path('../..', __FILE__)

  helpers Sinatra::UrlForHelper

  def feed_persistence_service
    @feed_persistence_service ||= FeedPersistenceService.new
  end

  def link_generator
    @link_generator ||= LinkGenerator.new(self)
  end

  def feed_generator
    @feed_generator = FeedGenerator.new(link_generator)
  end

  get '/' do
    haml :index
  end

  get %r{^/feeds/(.+)\.xml$} do |username|
    if feed = feed_persistence_service.find(username)
      content_type 'application/rss-xml'
      feed_generator.to_xml(feed)
    else
      halt 404
    end
  end

  get '/feeds/:username' do |username|
    @feed = feed_persistence_service.find(username)
    if @feed
      @feed_url = link_generator.generate_feed_link(@feed)
    end

    haml :show
  end

  post '/feeds' do
    # TODO empty username
    # TODO non existent lj user
    # TODO feed alreay exists

    # feed = Feed.new username: params['username']
    # FeedPopulator.new.populate feed

    feed = feed_persistence_service.find_or_create(params['username'])
    redirect "/feeds/#{feed.username}"
  end
end
