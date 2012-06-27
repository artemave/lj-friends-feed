class Feed
  attr_reader :username

  def initialize(opts = {}, feed_generator = FeedGenerator.new)
    @feed_generator = feed_generator
    @entries      = opts[:entries] || FeedEntries.new
    @username     = opts[:username]
  end

  def entries
    @entries
  end

  def to_xml
    @feed_generator.to_xml(self)
  end

  def title
    "#@username friends posts"
  end

  alias_method :description, :title

  def link
    "http://#@username.livejournal.com/friends/"
  end
end
