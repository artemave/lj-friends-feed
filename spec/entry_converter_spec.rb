require_relative 'spec_helper'

describe EntryConverter do
  let(:entry_converter) { EntryConverter.new }
  let(:entry) { build(:entry) }
  let(:item) { entry_converter.entry_to_rss_item(entry) }

  it 'converts feed entry into rss item' do
    item.should respond_to(:guid)
    item.should respond_to(:pubDate)
    item.should respond_to(:title)
    item.should respond_to(:link)
    item.should respond_to(:description)
  end

  it 'sets guid to entry link' do
    item.guid.should == entry.link
  end

  it 'sets link to entry link' do
    item.link.should == entry.link
  end

  it 'sets description to entry content' do
    item.description.should == entry.content
  end

  it 'sets pubDate to entry pub_date string representation' do
    item.pubDate.should == entry.pub_date.to_s
  end

  it 'sets title to entry author and title' do
    item.title.should == "#{entry.author} - #{entry.title}"
  end
end
