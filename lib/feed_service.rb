class FeedService
  def initialize(feed_generator = FeedGenerator.new)
    @feed_generator = feed_generator
  end

  def to_xml(model)
    @feed_generator.title       = model.title
    @feed_generator.link        = model.link
    @feed_generator.description = model.description
    @feed_generator.generate
  end
end
