require_relative 'spec_helper'

describe FeedPopulator do
  let(:entry1) { build :entry }
  let(:entry2) { build :entry }
  let(:entry_fetcher) { stub(:entry_fetcher) }
  let(:feed_populator) { FeedPopulator.new entry_fetcher }
  let(:feed) { Feed.new username: 'artemave' }

  it 'populates feed with posts from livejournal' do
    entry_fetcher.stub(:fetch_for_user).with('artemave').and_return([entry1, entry2])

    feed_populator.populate feed
    feed.entries.should == [entry1, entry2]
  end
end
