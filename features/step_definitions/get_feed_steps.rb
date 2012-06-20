Given /^there is a feed for a user$/ do
  @expected_feed = build :feed
end

When /^I get it with feed reader$/ do
  @actual_feed = RSS::Parser.parse(@expected_feed.to_xml)
end
