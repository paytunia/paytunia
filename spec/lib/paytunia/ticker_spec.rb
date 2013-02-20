require_relative '../../spec_helper'

describe Paytunia::Ticker do
  it "must work" do
    "Yay! I'm the king".must_be_instance_of String
  end

  describe "GET Ticker informations" do
    let(:ticker) {Paytunia::Connection.get_ticker }
    before do
      VCR.insert_cassette 'ticker', :record => :new_episodes
    end
    after do
      VCR.eject_cassette
    end

    ##uncomment to record new cassette-fixture
    #it "records the fixture with VRC gem" do
    #  Paytunia::Connection.get_ticker
    #end

    it "must have all method" do
      %w(high low volume bid ask midpoint at price variation currency).each do |method|
        ticker.must_respond_to method.to_sym
      end

    end

    it "must perform the request and get the correct datas format" do
      %w(high low volume bid ask midpoint price variation).each do |method|
        print ticker.send(method)
        ticker.send(method).must_be_instance_of Float
      end
      ticker.at.must_be_instance_of Fixnum
      ticker.currency.must_be_instance_of String

      #some test value from the cassette, to be change if the cassette is recorded again
      ticker.low.must_equal 21.701
      ticker.high.must_equal 23.99

    end
  end
end