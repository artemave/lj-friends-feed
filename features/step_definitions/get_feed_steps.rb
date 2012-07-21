Given /^there is a feed for my lj user$/ do
  entries = [build(:entry), build(:entry)]
  @internal_feed = Feed.new(username: 'artemave', entries: entries)
  FeedPersistenceService.new.create @internal_feed
end

When /^I subscribe to that feed$/ do
  get "/feeds/#{@internal_feed.username}.xml"
  @actual_feed = RSS::Parser.parse(last_response.body)
end

Then /^I should see my friends posts$/ do
  @actual_feed.should have_data_from(@internal_feed)
end
