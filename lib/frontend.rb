require 'sinatra/base'
require 'sinatra/reloader' if ENV['RACK_ENV'] != 'production'
require 'haml'
require 'sinatra/url_for'
require 'rack-flash'
require_relative 'feed_persistence_service'
require_relative 'feed_generator'
require_relative 'link_generator'

class Frontend < Sinatra::Base
  set :root, File.expand_path('../..', __FILE__)

  enable :sessions
  use Rack::Flash, :sweep => true

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
      content_type 'application/rss+xml'
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
    feed = feed_persistence_service.find_or_create(params['username'])
    flash[:notice] = 'Feed created!'
    redirect "/feeds/#{feed.username}"
  end
end
