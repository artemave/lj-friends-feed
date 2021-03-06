require_relative 'spec_helper'
require_relative '../lib/friend_entries_fetcher'

describe FriendEntriesFetcher do
  let(:lj_driver) { double(:lj_driver) }
  let(:rss_items_extractor) { double(:rss_items_extractor) }
  let(:friend_entries_fetcher) { FriendEntriesFetcher.new lj_driver, rss_items_extractor }

  it 'fetches user entries' do
    entry1, entry2 = build(:entry), build(:entry)

    lj_driver.stub(:user_rss).with('artemave').and_return('xml')
    rss_items_extractor.stub(:extract_items).with('xml').and_return([entry1, entry2])

    entries = friend_entries_fetcher.fetch 'artemave'
    entries.should == [entry1, entry2]
  end

  it 'returns empty list as entries for wrong usernames' do
    lj_driver.stub(:user_rss).with('_artem').and_raise(LjDriver::BadUserName)
    
    entries = friend_entries_fetcher.fetch '_artem'
    entries.should == []
  end
end
