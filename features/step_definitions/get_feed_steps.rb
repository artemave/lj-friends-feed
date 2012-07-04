Given /^there is a feed for my lj user$/ do
  entries = FeedEntries.new([build(:entry), build(:entry)])
  @internal_feed = Feed.new(username: 'artemave', entries: entries)
end

When /^I subscribe to that feed$/ do
  @actual_feed = RSS::Parser.parse(FeedGenerator.new.to_xml(@internal_feed))
end

Then /^I should see my friends posts$/ do
  @actual_feed.should have_data_from(@internal_feed)
end
