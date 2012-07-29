require_relative 'spec_helper'
require_relative '../lib/lj_driver'
require 'faraday'

describe LjDriver do
  let(:conn) do
    Faraday.new do |builder|
      # those stubs suck, because faraday is loosing hostname part of url somewhere
      builder.adapter :test do |stub|
        stub.get '/misc/fdata.bml?user=artemave' do 
          [200, {}, 'data']
        end
        stub.get '/data/rss' do 
          [200, {}, 'xml']
        end
        stub.get '/data/rss' do 
          [200, {}, 'xml']
        end
      end
    end
  end
  let(:lj_driver) { LjDriver.new conn }

  it 'fetches user friends data' do
    data = lj_driver.friends_data 'artemave'
    data.should == 'data'
  end

  it 'fetches user rss' do
    xml = lj_driver.user_rss 'artemave'
    xml.should == 'xml'
  end

  it 'changes username subdomain according to lj idiotic rules' do
    xml = lj_driver.user_rss 'artem_ave'
    xml.should == 'xml'
  end

  it 'raises LjDriver::BadUserName if name starts or finishes with _' do
    expect { lj_driver.user_rss '_artem' }.to raise_error(LjDriver::BadUserName)
    expect { lj_driver.user_rss 'artem_' }.to raise_error(LjDriver::BadUserName)
  end
end
