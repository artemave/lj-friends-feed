require_relative '../lib/feed'

describe Feed, 'model of RSS feed' do
  let(:feed_service) { mock(:feed_service) }
  let(:entries) { mock(:entries) }
  let(:feed) { Feed.new({ username: 'artemave', entries: entries }, feed_service)}

  it 'generates RSS feed' do
    feed_service.should_receive(:to_xml).with(feed)
    feed.to_xml
  end

  it 'makes feed title out of lj username' do
    feed.title.should == 'artemave friends posts'
  end

  it 'makes feed link out of lj username' do
    feed.link.should == "http://artemave.livejournal.com/friends/"
  end

  it 'makes feed description out of lj username' do
    feed.description.should == 'artemave friends posts'
  end

  describe 'feed entries' do
    it 'can be fetched' do
      feed.entries.should == entries
    end
  end
end
