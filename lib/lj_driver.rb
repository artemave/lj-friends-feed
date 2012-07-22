require 'faraday'

class LjDriver
  def initialize conn = nil
    @conn = conn || Faraday.new do |faraday|
      faraday.response :logger
      faraday.response :raise_error
      faraday.adapter Faraday.default_adapter
    end
    @conn.headers['User-Agent'] = "LjFriendsFeed - https://github.com/artemave/lj-friends-feed"
  end

  def friends_data user
    resp = @conn.get "http://www.livejournal.com/misc/fdata.bml", user: user
    resp.body
  end

  def user_rss user
    resp = @conn.get "http://#{comply_with_lj_idiocy user}.livejournal.com/data/rss"
    resp.body
  end

  private

    def comply_with_lj_idiocy user
      user.gsub('_', '-')
    end
end
