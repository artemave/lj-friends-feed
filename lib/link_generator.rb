class LinkGenerator
  def initialize url_provider
    @url_provider = url_provider
  end

  def generate_feed_link feed
    @url_provider.url_for "/feeds/#{feed.username}.xml", :full
  end
end
