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

  it 'returns nil if no feed is found' do
    feed = feed_persistence_service.find('blah')
    feed.should == nil
  end

  context '#find_or_create' do
    it 'finds if exists' do
      feed_persistence_service.create(expected_feed)
      feed = feed_persistence_service.find_or_create(expected_feed.username)

      feed.should equal_to(expected_feed)
    end

    it 'creates if does not exist' do
      feed = feed_persistence_service.find_or_create(expected_feed.username)

      feed.should equal_to(expected_feed)
    end
  end
end
