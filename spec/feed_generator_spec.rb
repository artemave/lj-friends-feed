require 'rss'
require_relative '../lib/feed_generator'

describe FeedGenerator do
  let(:feed_gen) {
    fg             = FeedGenerator.new
    fg.title       = 'required dummy'
    fg.link        = 'required dummy'
    fg.description = 'required dummy'
    fg
  }

  it 'generates rss xml' do
    expect { RSS::Parser.parse(feed_gen.generate) }.to_not raise_error
  end

  it 'sets channel title' do
    title = 'artemave friends posts'

    feed_gen.title = title
    feed = RSS::Parser.parse(feed_gen.generate)

    feed.channel.title.should == title
  end
end
