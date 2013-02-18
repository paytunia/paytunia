require_relative '../../spec_helper'

describe Paytunia::Trading do
  it "must work" do
    "Yay! I'm the king".must_be_instance_of String
  end

  describe "default configuration" do
    it "must include httparty methods" do
      Paytunia::Trading.must_include HTTParty
    end
    it "must have the base url set to the Dribble API endpoint" do
      Paytunia::Trading.base_uri.must_equal 'https://bitcoin-central.net/api/v1'
    end
  end

  describe "GET orders" do
    let(:trade_orders) { Paytunia::Trading.new.trade_orders }
    before do
      VCR.insert_cassette 'trade_orders', :record => :new_episodes
    end
    after do
      VCR.eject_cassette
    end

    ##uncomment to record new ficture
    #it "records the fixture with VRC gem" do
    #  Paytunia::Trading.get('/trade_orders')
    #end

    it "must count 5 orders in total" do
      trade_orders.count.must_equal 5
    end

  end
end