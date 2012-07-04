class EntryFetcher
  def initialize friends_fetcher = FriendsFetcher.new, user_entries_fetcher = UserEntriesFetcher.new
    @friends_fetcher      = friends_fetcher
    @user_entries_fetcher = user_entries_fetcher
  end

  def fetch_for_user username
    [].tap do |entries|
      @friends_fetcher.fetch(username).each do |user|
        entries.concat @user_entries_fetcher.fetch(user)
      end
    end
  end
end
