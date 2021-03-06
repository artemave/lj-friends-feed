require 'rss'
require_relative 'item_populator'
require_relative 'link_generator'

class FeedGenerator
  def initialize(link_generator, item_populator = ItemPopulator.new)
    @item_populator = item_populator
    @link_generator = link_generator
  end

  def to_xml(model)
    feed = RSS::Maker.make('2.0') do |m|
      m.channel.title       = model.title
      m.channel.link        = @link_generator.generate_feed_link(model)
      m.channel.description = model.description

      (model.entries || []).each do |entry|
        m.items.new_item do |item|
          @item_populator.populate(item, entry)
        end
      end
    end
    feed.to_s
  end
end
