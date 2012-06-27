class ItemPopulator
  def populate item, entry
    item.guid.content = entry.link
    item.link         = entry.link
    item.description  = entry.content
    item.pubDate      = entry.pub_date.to_s
    item.title        = "#{entry.author} - #{entry.title}"
  end
end
