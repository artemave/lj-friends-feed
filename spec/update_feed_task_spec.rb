require_relative 'spec_helper'
require_relative '../lib/update_feed_task'
require_relative '../lib/feed'

describe UpdateFeedTask do
  let(:feed_updater) { double(:feed_updater) }
  let(:feed_persistence_service) { double(:feed_persistence_service) }
  let(:update_feed_task) { UpdateFeedTask.new feed_persistence_service, feed_updater }
  let(:feed1) { Feed.new username: 'alice' }
  let(:feed2) { Feed.new username: 'bob' }

  before do
    allow(feed_persistence_service).to receive(:all).and_return([feed1, feed2])
  end

  it 'updates all existing feeds' do
    expect(feed_updater).to receive(:update).with(feed1)
    expect(feed_updater).to receive(:update).with(feed2)

    update_feed_task.invoke
  end

  it 'isolates individual update feed failure' do
    expect(feed_updater).to receive(:update).with(feed1).and_raise
    expect(feed_updater).to receive(:update).with(feed2).and_raise

    update_feed_task.invoke
  end
end
