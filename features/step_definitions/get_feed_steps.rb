Given /^there is a feed for a user$/ do
  @internal_feed = Feed.new(username: 'artemave')
end

When /^I get it with feed reader$/ do
  @actual_feed = RSS::Parser.parse(@internal_feed.to_xml)
end

Then /^it should show its contents$/ do
  @actual_feed.should have_data_from(@internal_feed)
end
