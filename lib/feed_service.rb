class FeedService
  def initialize(feed_generator = FeedGenerator.new)
    @feed_generator = feed_generator
  end

  def to_xml(model)
    @feed_generator.generate
  end
end
