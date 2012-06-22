Given /^there is a feed for my lj user$/ do
  @internal_feed = Feed.new(username: 'artemave')
end

When /^I subscribe to that feed$/ do
  @actual_feed = RSS::Parser.parse(@internal_feed.to_xml)
end

Then /^I should see my friends posts$/ do
  @actual_feed.should have_data_from(@internal_feed)
end
