class LjDriver
  def initialize http_client = RestClient
    @http_client = http_client
  end

  def friends_data user
    @http_client.get "http://www.livejournal.com/misc/fdata.bml?user=#{user}"
  end
end
