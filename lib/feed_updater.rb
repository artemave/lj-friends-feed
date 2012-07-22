require_relative 'entry_fetcher'
require_relative 'feed_persistence_service'

class FeedUpdater
  def initialize entry_fetcher = EntryFetcher.new, feed_persistence_service = FeedPersistenceService.new
    @entry_fetcher            = entry_fetcher
    @feed_persistence_service = feed_persistence_service
  end

  def update feed
    @entry_fetcher.fetch_for_user(feed.username).each do |entry|
      feed.entries << entry
    end

    @feed_persistence_service.update feed
  end
end
