require_relative 'feed_persistence_service'
require_relative 'feed_updater'

class UpdateFeedTask
  def initialize feed_persistence_service = FeedPersistenceService.new, feed_updater = FeedUpdater.new
    @feed_persistence_service = feed_persistence_service
    @feed_updater = feed_updater
  end

  def invoke
    @feed_persistence_service.all.each do |feed|
      begin
        @feed_updater.update feed
      rescue Exception => e
        puts "Feed update failed for username: #{feed.username}: #{e.inspect}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
