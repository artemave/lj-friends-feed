class Feed
  attr_reader :username

  def initialize(opts = {})
    @entries      = opts[:entries] || FeedEntries.new
    @username     = opts[:username]
  end

  def entries
    @entries
  end

  def title
    "#@username friends posts"
  end

  alias_method :description, :title

  def link
    "http://#@username.livejournal.com/friends/"
  end
end
