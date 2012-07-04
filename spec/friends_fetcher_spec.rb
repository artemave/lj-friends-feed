require_relative 'spec_helper'

describe FriendsFetcher do
  let(:friends_fetcher) { FriendsFetcher.new(lj_driver) }
  let(:lj_driver) { stub(:lj_driver) }

  it 'fetches friends of a user' do
    lj_driver.stub(:friends_data).with('artemave').and_return "
# Note: Polite data miners cache on their end.  Impolite ones get banned.
> olexdorfman
> artem_test
< th0m
< leocrazy
< autrement_que
< koot
    "
    friends = friends_fetcher.fetch('artemave')
    friends.should =~ ['olexdorfman', 'artem_test']
  end
end
