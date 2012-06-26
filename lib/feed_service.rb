class FeedService
  def initialize(feed_generator = FeedGenerator.new, entry_converter = EntryConverter.new)
    @feed_generator  = feed_generator
    @entry_converter = entry_converter
  end

  def to_xml(model)
    @feed_generator.title       = model.title
    @feed_generator.link        = model.link
    @feed_generator.description = model.description

    @feed_generator.items = model.entries.map do |e|
      @entry_converter.entry_to_rss_item(e)
    end

    @feed_generator.generate
  end
end
