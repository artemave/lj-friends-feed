require_relative 'spec_helper'
require_relative 'db_helper'

require_relative '../lib/feed_persistence_service'

describe FeedPersistenceService do
  let (:feed_persistence_service) { FeedPersistenceService.new }
  let(:expected_feed) { Feed.new username: 'artemave' }

  it 'persists feed' do
    feed_persistence_service.create(expected_feed)

    feed = feed_persistence_service.find(expected_feed.username)

    feed.should equal_to(expected_feed)
  end

  it 'finds all' do
    feed_persistence_service.create(feed1 = Feed.new(username: 'alice'))
    feed_persistence_service.create(feed2 = Feed.new(username: 'bob'))

    feeds = feed_persistence_service.all

    feeds.first.should equal_to(feed1)
    feeds.last.should equal_to(feed2)
  end

  it 'returns nil if no feed is found' do
    feed = feed_persistence_service.find('blah')
    feed.should == nil
  end

  describe '#find_or_create' do
    it 'finds feed if it exists' do
      feed_persistence_service.create(expected_feed)
      feed = feed_persistence_service.find_or_create(expected_feed.username)

      feed.should equal_to(expected_feed)
    end

    it 'creates feed if one does not exist' do
      feed = feed_persistence_service.find_or_create(expected_feed.username)

      feed.should equal_to(expected_feed)
    end
  end

  context 'entries' do
    it 'persists entries' do
      entry1, entry2 = build(:entry), build(:entry)
      expected_feed.entries << entry1 << entry2
      feed_persistence_service.create expected_feed

      feed = feed_persistence_service.find(expected_feed.username)

      feed.entries.should == [entry1, entry2]
    end

    it 'updates entries' do
      entry1, entry2, entry3 = 3.times.map { build :entry }
      expected_feed.entries << entry1 << entry2
      feed_persistence_service.create expected_feed

      expected_feed.entries.pop
      expected_feed.entries << entry3
      feed_persistence_service.update expected_feed

      feed = feed_persistence_service.find(expected_feed.username)

      feed.entries.should == [entry1, entry3]
    end
  end
end
