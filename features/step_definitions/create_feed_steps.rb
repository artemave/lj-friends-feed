Given /^there is a livejournal user$/ do
  puts 'VCR stuff will go here when the app starts talking to livejournal'
end

When /^I create a feed for that user$/ do
  create_feed
end

Then /^I should see that feed is created$/ do
  page.should_not have_errors
  page.should have_content('feed created')
end
