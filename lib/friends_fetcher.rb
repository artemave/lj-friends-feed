class FriendsFetcher
  def initialize lj_driver = LjDriver.new
    @lj_driver = lj_driver
  end

  def fetch user
    friends_data = @lj_driver.friends_data(user)
    extract_friends(friends_data)
  end

  private

    def extract_friends friends_data
      friends_data.split("\n").select do |line|
        line =~ /^>/
      end.map do |friend_line|
        friend_line[/\w+/]
      end
    end
end
