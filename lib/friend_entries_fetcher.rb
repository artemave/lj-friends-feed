require_relative 'lj_driver'
require_relative 'rss_items_extractor'

class FriendEntriesFetcher
  def initialize lj_driver = LjDriver.new, rss_items_extractor = RssItemsExtractor.new
    @lj_driver           = lj_driver
    @rss_items_extractor = rss_items_extractor
  end

  def fetch user
    xml = @lj_driver.user_rss user
    @rss_items_extractor.extract_items xml
  end
end
