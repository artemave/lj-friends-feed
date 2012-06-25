class Feed
  attr_reader :username

  def initialize(opts = {}, feed_service = FeedService.new, feed_entries = FeedEntries.new)
    @feed_service = feed_service
    @feed_entries = feed_entries
    @username     = opts[:username]
  end

  def entries
    @feed_entries
  end

  def to_xml
    @feed_service.to_xml(self)
  end

  def title
    "#@username friends posts"
  end

  alias_method :description, :title

  def link
    "http://#@username.livejournal.com/friends/"
  end
end
