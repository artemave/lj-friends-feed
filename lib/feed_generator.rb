require 'rss'

class FeedGenerator
  def initialize(item_populator = ItemPopulator.new)
    @item_populator = item_populator
  end

  def to_xml(model)
    feed = RSS::Maker.make('2.0') do |m|
      m.channel.title       = model.title
      m.channel.link        = model.link
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
