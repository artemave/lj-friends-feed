RSpec::Matchers.define :have_data_from do |internal_feed|
  match do |actual_feed|
    actual_feed.channel.title =~ /#{internal_feed.username}/
    actual_feed.items.size.should == internal_feed.items.size
  end
end
