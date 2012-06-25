RSpec::Matchers.define :have_data_from do |internal_feed|
  match do |actual_feed|
    actual_feed.channel.title =~ /#{internal_feed.username}/
    actual_feed.entries.size.should == internal_feed.entries.size
  end
end
