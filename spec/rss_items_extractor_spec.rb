require_relative 'spec_helper'
require 'rss'
require_relative '../lib/rss_items_extractor'

describe RssItemsExtractor do
  let (:entry1) { build :entry }
  let (:entry2) { build :entry, author: entry1.author }
  let (:entry3) { build :entry }
  let (:rss_items_extractor) { RssItemsExtractor.new }

  let (:xml) do
    RSS::Maker.make("2.0") do |maker|
      maker.channel.title       = entry1.author
      maker.channel.link        = 'http://blahhabl.blah'
      maker.channel.description = 'feed description'

      maker.items.new_item do |item|
        item.guid.content = entry1.link
        item.link         = entry1.link
        item.title        = entry1.title
        item.pubDate      = entry1.pub_date
        item.description  = entry1.content
      end

      maker.items.new_item do |item|
        item.guid.content = entry2.link
        item.link         = entry2.link
        item.title        = entry2.title
        item.pubDate      = entry2.pub_date
        item.description  = entry2.content
      end

      maker.items.new_item do |item|
        item.guid.content = entry2.link # duplicate guid!
        item.link         = entry2.link
        item.title        = entry3.title
        item.pubDate      = entry3.pub_date
        item.description  = entry3.content
      end
    end.to_s
  end

  it 'extracts array of entries (except for duplicates) from rss xml' do
    entries = rss_items_extractor.extract_items xml
    entries.should =~ [entry1, entry2]
  end
end
