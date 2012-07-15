require 'feed'

class FeedPersistenceService
  class MongoFeed
    include Mongoid::Document

    field :username, type: String
    validates_uniqueness_of :username
  end
  
  def create feed
    MongoFeed.create username: feed.username
    feed
  end

  def find feed_id
    f = MongoFeed.find_by username: feed_id
    Feed.new username: f.username
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def find_or_create feed_id
    find(feed_id) or create(Feed.new username: feed_id)
  end
end
