require_relative 'spec_helper'

describe FeedEntries do
  it 'contains feed entries' do
    entries = FeedEntries.new([e1 = build(:entry), e2 = build(:entry)])

    entries.first.should == e1
    entries.last.should == e2
  end

  it 'contains only feed entries' do
    expect { FeedEntries.new [build(:entry), build(:entry)] }.to_not raise_error
    expect { FeedEntries.new [1, {link: 'link'}] }.to raise_error
  end
end
