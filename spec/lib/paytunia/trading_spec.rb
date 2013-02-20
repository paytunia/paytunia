require_relative '../../spec_helper'

describe Paytunia::Trading do
  describe "default configuration" do
    it "must have the base url set to paytunia.com" do
      Paytunia.base_uri.must_equal 'https://bitcoin-central.net'
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