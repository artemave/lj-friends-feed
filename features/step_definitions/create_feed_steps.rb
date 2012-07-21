When /^I create a feed for a username$/ do
  create_feed 'artemave'
end

Then /^I should see that feed is created$/ do
  page.should_not have_errors
  page.should have_content('Feed created')
end

Then /^I should be able to subscribe to it$/ do
  page.should have_css "a[href='http://www.example.com/feeds/artemave.xml']"
end
