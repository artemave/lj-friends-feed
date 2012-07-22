require_relative 'friends_fetcher'
require_relative 'user_entries_fetcher'

class EntryFetcher
  def initialize friends_fetcher = FriendsFetcher.new, user_entries_fetcher = UserEntriesFetcher.new
    @friends_fetcher      = friends_fetcher
    @user_entries_fetcher = user_entries_fetcher
  end

  def fetch_for_user username
    entries = []
    threads = []
    @friends_fetcher.fetch(username).each do |user|
      threads << Thread.new do
        entries.concat @user_entries_fetcher.fetch(user)
      end
    end
    threads.each(&:join)
    entries
  end
end
