class Feed
  attr_reader :username
  attr_accessor :entries

  def initialize(opts = {})
    @entries  = opts[:entries] || []
    @username = opts[:username]
  end

  def title
    "#@username friends posts"
  end

  alias_method :description, :title
end
