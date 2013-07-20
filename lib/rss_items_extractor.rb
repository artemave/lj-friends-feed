require 'rss'
require_relative 'entry'

class RssItemsExtractor
  def extract_items xml
    rss = RSS::Parser.parse xml

    [].tap do |entries|
      rss.items.each do |item|
        entries << Entry.new(
            author: rss.channel.title,
             title: item.title,
          pub_date: item.pubDate,
           content: item.description,
              link: item.link
        )
      end
    end
  end
end
