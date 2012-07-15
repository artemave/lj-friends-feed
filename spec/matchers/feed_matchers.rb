# compares RSS feeds
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

# compares feed objects
RSpec::Matchers.define :equal_to do |expected_feed|
  match do |actual_feed|
    @errors = []

    if actual_feed.username != expected_feed.username
      @errors < "Username mismatch: expected: #{expected_feed.username}, got: #{actual_feed.username}"
    end

    if actual_feed.entries != expected_feed.entries
      @errors < "Entries mismatch: expected: #{expected_feed.entries}, got: #{actual_feed.entries}"
    end

    @errors.empty?
  end

  failure_message_for_should do
    @errors.join("\n")
  end
end
