require_relative '../lib/feed'

describe Feed, 'model of RSS feed' do
  let(:entries) { double(:entries) }
  let(:feed) { Feed.new({ username: 'artemave', entries: entries })}

  it 'makes feed title out of lj username' do
    feed.title.should == 'artemave friends posts'
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
