require_relative 'spec_helper'
require_relative '../lib/feed_updater'
require_relative '../lib/feed'

describe FeedUpdater do
  let(:entry1) { build :entry }
  let(:entry2) { build :entry }
  let(:entry_fetcher) { double :entry_fetcher }
  let(:feed_persistence_service) { double(:feed_persistence_service).as_null_object }
  let(:feed_updater) { FeedUpdater.new entry_fetcher, feed_persistence_service }
  let(:feed) { Feed.new username: 'artemave' }

  it 'populates feed with posts from livejournal' do
    entry_fetcher.stub(:fetch_for_user).with('artemave').and_return([entry1, entry2])

    feed_updater.update feed
    feed.entries.should == [entry1, entry2]
  end

  it 'persists updated feed' do
    entry_fetcher.should_receive(:fetch_for_user).with('artemave').ordered.and_return([])
    feed_persistence_service.should_receive(:update).with(feed).ordered

    feed_updater.update feed
  end
end
