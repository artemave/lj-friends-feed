require_relative '../lib/feed_service'

describe FeedService do
  let(:feed_generator) { mock(:feed_generator).as_null_object }
  let(:feed_service) { FeedService.new(feed_generator) }
  let(:feed_model) { stub(:feed_model).as_null_object }

  it 'takes feed model and produces xml using feed generator' do
    feed_generator.should_receive(:generate)
    feed_service.to_xml(feed_model)
  end

  describe 'takes model data and passes it into feed generator before generating xml' do
    it 'sets channel title' do
      feed_model.stub(:title).and_return('artemave')
      feed_generator.should_receive(:title=).with('artemave').ordered
      feed_generator.should_receive(:generate).ordered

      feed_service.to_xml(feed_model)
    end
  end
end
