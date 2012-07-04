require_relative 'spec_helper'

describe LjDriver do
  let(:http_client) { stub :http_client }
  let(:lj_driver) { LjDriver.new http_client }

  it 'fetches user friends data' do
    http_client.stub(:get).with('http://www.livejournal.com/misc/fdata.bml?user=artemave').and_return('data')
    data = lj_driver.friends_data 'artemave'
    data.should == 'data'
  end

  it 'fetches user rss' do
    http_client.stub(:get).with('http://artemave.livejournal.com/data/rss').and_return('xml')
    xml = lj_driver.user_rss 'artemave'
    xml.should == 'xml'
  end
end
