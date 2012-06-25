require 'rss'

class FeedGenerator
  attr_writer :title, :link, :description

  def generate
    feed = RSS::Maker.make('2.0') do |m|
      m.channel.title       = @title
      m.channel.link        = @link
      m.channel.description = @description
    end
    feed.to_s
  end
end
