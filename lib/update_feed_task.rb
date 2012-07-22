class UpdateFeedTask
  def initialize feed_persistence_service = FeedPersistenceService.new, feed_updater = FeedUpdater.new
    @feed_persistence_service = feed_persistence_service
    @feed_updater = feed_updater
  end

  def invoke
    puts "Start update: #{Time.now}"
    @feed_persistence_service.all.each do |feed|
      @feed_updater.update feed
    end
    puts "Update finished: #{Time.now}"
  end
end
