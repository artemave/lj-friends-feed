require 'rss'
require_relative 'spec_helper'

describe FeedGenerator do
  let(:item_populator) { double(:item_populator) }
  let(:feed_gen) { FeedGenerator.new item_populator }
  let(:model) {
    stub :model,
      title: 'artemave friends posts',
      link: 'link',
      description: 'description',
      entries: []
  }

  it 'generates rss xml' do
    expect { RSS::Parser.parse(feed_gen.to_xml(model)) }.to_not raise_error
  end

  it 'generates channel title' do
    title = 'artemave friends posts'

    model.stub(:title).and_return(title)
    feed = RSS::Parser.parse(feed_gen.to_xml(model))

    feed.channel.title.should == title
  end

  it 'generates channel link' do
    link = 'http://artemave.livejournal.com/friends/'

    model.stub(:link).and_return(link)
    feed = RSS::Parser.parse(feed_gen.to_xml(model))

    feed.channel.link.should == link
  end
  
  it 'generates channel description' do
    description = 'blah blah blah'

    model.stub(:description).and_return(description)
    feed = RSS::Parser.parse(feed_gen.to_xml(model))

    feed.channel.description.should == description
  end

  describe 'feed items' do
    let(:entry1) { build(:entry) }
    let(:entry2) { build(:entry) }

    before do
      model.stub(:entries).and_return [entry1, entry2]
    end

    it 'populates feed items from entries' do
      item_populator.should_receive(:populate).with(anything(), entry1)
      item_populator.should_receive(:populate).with(anything(), entry2)

      feed_gen.to_xml(model)
    end

    it 'generates feed items from entries' do
      item_populator.stub(:populate) do |item|
        item.title = 'title'
      end
      feed = RSS::Parser.parse(feed_gen.to_xml(model))
      feed.items.size.should == 2
    end
  end
end
