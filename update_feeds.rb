# to see stdout in docker logs
STDOUT.sync = true

require_relative './lib/update_feed_task'

task = UpdateFeedTask.new

begin
  puts "Update feeds start: #{Time.now}"
  task.invoke
  puts "Update feeds finish: #{Time.now}"
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
end
