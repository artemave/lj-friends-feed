require_relative 'feed'
require_relative 'entry'

class FeedPersistenceService
  class MongoFeed
    include Mongoid::Document

    field :username
    embeds_many :mongo_entries

    validates_uniqueness_of :username
  end

  class MongoEntry
    include Mongoid::Document

    field :author
    field :link
    field :pub_date
    field :content
    field :title
  end
  
  def create feed
    mongo_entries = feed.entries.map do |e|
      MongoEntry.new e.to_hash
    end
    MongoFeed.create username: feed.username, mongo_entries: mongo_entries
    feed
  end

  def update feed
    mongo_entries = feed.entries.map do |e|
      MongoEntry.new e.to_hash
    end
    mf = MongoFeed.find_by username: feed.username
    mf.mongo_entries = mongo_entries
    mf.save
    feed
  end

  def find feed_id
    f = MongoFeed.find_by username: feed_id
    entries = f.mongo_entries.map do |me|
      Entry.new me.as_document.except("_id").symbolize_keys
    end
    Feed.new username: f.username, entries: entries
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def find_or_create feed_id
    find(feed_id) or create(Feed.new username: feed_id)
  end
end
