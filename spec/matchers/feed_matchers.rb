RSpec::Matchers.define :have_data_from do |internal_feed|
  match do |actual_feed|
    @errors = []
    
    if actual_feed.channel.title !~ /#{internal_feed.username}/
      @errors << "Feed title mismatch: expected: '#{actual_feed.channel.title}' to contain '#{internal_feed.username}'"
    end

    if actual_feed.items.size != internal_feed.entries.size
      @errors << "Number of feed entries don't match: expected: '#{internal_feed.entries.size}' got: '#{actual_feed.items.size}'"
    end

    @errors.empty?
  end

  failure_message_for_should do
    @errors.join("\n")
  end
end
