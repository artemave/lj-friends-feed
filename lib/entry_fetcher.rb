require_relative 'friends_fetcher'
require_relative 'friend_entries_fetcher'

class EntryFetcher
  def initialize friends_fetcher = FriendsFetcher.new, friend_entries_fetcher = FriendEntriesFetcher.new
    @friends_fetcher      = friends_fetcher
    @friend_entries_fetcher = friend_entries_fetcher
  end

  def fetch_for_user username
    entries = []
    threads = []
    @friends_fetcher.fetch(username).each do |user|
      threads << Thread.new do
        entries.concat @friend_entries_fetcher.fetch(user)
      end
    end
    threads.each(&:join)
    entries
  end
end
