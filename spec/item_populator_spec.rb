require_relative 'spec_helper'

describe ItemPopulator do
  let(:item_populator) { ItemPopulator.new }
  let(:item) { double(:item).as_null_object }
  let(:entry) { build :entry }

  it 'populates feed item from entry' do
    expect { item_populator.populate item, entry }.to_not raise_error
  end

  it 'sets guid to entry link' do
    content_setter = mock(:content_setter)

    item.stub(:guid).and_return(content_setter)
    content_setter.should_receive(:content=).with(entry.link)
    item_populator.populate item, entry
  end

  it 'sets link to entry link' do
    item.should_receive(:link=).with(entry.link)
    item_populator.populate item, entry
  end

  it 'sets description to entry content' do
    item.should_receive(:description=).with(entry.content)
    item_populator.populate item, entry
  end

  it 'sets pubDate to entry pub_date string representation' do
    item.should_receive(:pubDate=).with(entry.pub_date.to_s)
    item_populator.populate item, entry
  end

  it 'sets title to entry author and title' do
    item.should_receive(:title=).with("#{entry.author} - #{entry.title}")
    item_populator.populate item, entry
  end
end
