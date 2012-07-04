require_relative 'spec_helper'

describe UserEntriesFetcher do
  let(:lj_driver) { stub(:lj_driver) }
  let(:rss_items_extractor) { stub(:rss_items_extractor) }
  let(:user_entries_fetcher) { UserEntriesFetcher.new lj_driver, rss_items_extractor }

  it 'fetches user entries' do
    entry1, entry2 = build(:entry), build(:entry)

    lj_driver.stub(:user_rss).with('artemave').and_return('xml')
    rss_items_extractor.stub(:extract_items).with('xml').and_return([entry1, entry2])

    entries = user_entries_fetcher.fetch 'artemave'
    entries.should == [entry1, entry2]
  end
end
