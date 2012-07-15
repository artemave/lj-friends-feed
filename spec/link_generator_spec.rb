require_relative 'spec_helper'
require_relative '../lib/link_generator'
require_relative '../lib/feed'

describe LinkGenerator do
  let(:link_generator) { LinkGenerator.new url_provider }
  let(:url_provider) { double :url_provider }
  let(:feed) { Feed.new username: 'artem' }

  it 'generates feed url' do
    url_provider.stub(:url_for).with('/feeds/artem.xml', :full).and_return('url')

    link = link_generator.generate_feed_link(feed)

    link.should == 'url'
  end
end
