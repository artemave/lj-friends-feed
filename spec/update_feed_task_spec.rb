require_relative 'spec_helper'
require_relative '../lib/update_feed_task'
require_relative '../lib/feed'

describe UpdateFeedTask do
  let(:entry1) { build :entry }
  let(:entry2) { build :entry }
  let(:entry_fetcher) { double :entry_fetcher }
  let(:feed_persistence_service) { double(:feed_persistence_service).as_null_object }
  let(:update_feed_task) { UpdateFeedTask.new entry_fetcher, feed_persistence_service }
  let(:feed) { Feed.new username: 'artemave' }

  it 'populates feed with posts from livejournal' do
    entry_fetcher.stub(:fetch_for_user).with('artemave').and_return([entry1, entry2])

    update_feed_task.invoke feed
    feed.entries.should == [entry1, entry2]
  end

  it 'persists updated feed' do
    entry_fetcher.should_receive(:fetch_for_user).with('artemave').ordered.and_return([])
    feed_persistence_service.should_receive(:update).with(feed).ordered

    update_feed_task.invoke feed
  end
end
