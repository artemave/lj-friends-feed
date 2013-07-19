require_relative 'spec_helper'
require_relative '../lib/update_feed_task'
require_relative '../lib/feed'

describe UpdateFeedTask do
  let(:feed_updater) { double(:feed_updater) }
  let(:feed_persistence_service) { double(:feed_persistence_service) }
  let(:update_feed_task) { UpdateFeedTask.new feed_persistence_service, feed_updater }

  it 'updates all existing feeds' do
    feed1, feed2 = Feed.new(username: 'alice'), Feed.new(username: 'bob')
    feed_persistence_service.stub(:all).and_return([feed1, feed2])

    feed_updater.should_receive(:update).with(feed1)
    feed_updater.should_receive(:update).with(feed2)

    update_feed_task.invoke
  end

  it 'isolates individual update feed failure' do
    feed1, feed2 = Feed.new(username: 'alice'), Feed.new(username: 'bob')
    feed_persistence_service.stub(:all).and_return([feed1, feed2])

    feed_updater.should_receive(:update).with(feed1).and_raise
    feed_updater.should_receive(:update).with(feed2).and_raise

    update_feed_task.invoke
  end
end
