require_relative '../lib/feed_service'

describe FeedService do
  let(:entry_converter) { mock(:entry_converter) }
  let(:feed_generator) { mock(:feed_generator).as_null_object }
  let(:feed_service) { FeedService.new(feed_generator, entry_converter) }
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

    it 'sets channel link' do
      link = 'http://artemave.livejournal.com/friends/'
      feed_model.stub(:link).and_return(link)

      feed_generator.should_receive(:link=).with(link).ordered
      feed_generator.should_receive(:generate).ordered

      feed_service.to_xml(feed_model)
    end

    it 'sets channel description' do
      feed_model.stub(:description).and_return('description')

      feed_generator.should_receive(:description=).with('description').ordered
      feed_generator.should_receive(:generate).ordered

      feed_service.to_xml(feed_model)
    end

    it 'sets feed items' do
      feed_model.stub(:entries).and_return([e1 = double(:entry1), e2 = double(:entry2)])
      entry_converter.stub(:entry_to_rss_item) do |entry|
        entry
      end

      feed_generator.should_receive(:items=).with([e1, e2]).ordered
      feed_generator.should_receive(:generate).ordered

      feed_service.to_xml(feed_model)
    end
  end
end
