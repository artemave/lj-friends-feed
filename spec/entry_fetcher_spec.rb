require_relative 'spec_helper'
require_relative '../lib/entry_fetcher'

describe EntryFetcher do
  let(:entry_fetcher) { EntryFetcher.new(friends_fetcher, friend_entries_fetcher) }
  let(:friends_fetcher) { stub(:friends_fetcher) }
  let(:friend_entries_fetcher) { stub(:friend_entries_fetcher) }

  it 'fetches friends entries for lj user' do
    entry1, entry2, entry3 = 3.times.map { build :entry }

    friends_fetcher.stub(:fetch).with('artemave').and_return(['fedor_q', 'go', 'rokky'])
    friend_entries_fetcher.stub(:fetch).with('rokky').and_return([])
    friend_entries_fetcher.stub(:fetch).with('fedor_q').and_return([entry1, entry2])
    friend_entries_fetcher.stub(:fetch).with('go').and_return([entry3])

    entries = entry_fetcher.fetch_for_user('artemave')
    entries.should =~ [entry1, entry2, entry3]
  end

  xit 'sorts entries by date'
end
