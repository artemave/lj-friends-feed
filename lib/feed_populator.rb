class FeedPopulator
  def initialize entry_fetcher = EntryFetcher.new
    @entry_fetcher = entry_fetcher
  end

  def populate feed
    @entry_fetcher.fetch_for_user(feed.username).each do |entry|
      feed.entries << entry
    end
  end
end
