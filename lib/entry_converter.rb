require 'ostruct'

class EntryConverter
  def entry_to_rss_item entry
    item = OpenStruct.new
    item.guid        = entry.link
    item.title       = "#{entry.author} - #{entry.title}"
    item.description = entry.content
    item.link        = entry.link
    item.pubDate     = entry.pub_date.to_s
    item
  end
end
