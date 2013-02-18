require_relative '../../spec_helper'

describe Paytunia::Ticker do
  it "must work" do
    "Yay! I'm the king".must_be_instance_of String
  end

  describe "default configuration" do
    it "must include httparty methods" do
      Paytunia::Ticker.must_include HTTParty
    end
    it "must have the base url set to the Dribble API endpoint" do
      Paytunia::Ticker.base_uri.must_equal 'https://bitcoin-central.net/api/v1'
    end
  end

  describe "GET Ticker informations" do
    let(:ticker) { Paytunia::Ticker.new }
    before do
      VCR.insert_cassette 'ticker', :record => :new_episodes
    end
    after do
      VCR.eject_cassette
    end

    ##uncomment to record new ficture
    #it "records the fixture with VRC gem" do
    #  Paytunia::Ticker.get('/ticker')
    #end

    it "must have all method" do
      %w(high low volume bid ask midpoint at price variation currency).each do |method|
        ticker.must_respond_to method.to_sym
      end

    end

    it "must perform the request and get the correct datas" do
      ticker.high.must_equal 21.5
      ticker.low.must_equal 19.8
      ticker.volume.must_equal 802.24639442
      ticker.bid.must_equal 20.50004
      ticker.ask.must_equal 20.89946
      ticker.midpoint.must_equal 20.69975
      ticker.at.must_equal 1361223350
      ticker.price.must_equal 20.8995
      ticker.variation.must_equal 2.0483
      ticker.currency.must_equal "eur"
    end
  end
end