require_relative '../lib/feed_service'

describe FeedService do
  let(:feed_generator) { mock(:feed_generator) }
  let(:feed_service) { FeedService.new(feed_generator) }
  let(:feed_model) { mock(:feed_model) }

  it 'takes feed model and produces xml using feed generator' do
    feed_generator.should_receive(:generate)
    feed_service.to_xml(feed_model)
  end
end
