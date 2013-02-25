require_relative '../spec_helper'

describe 'Trading' do

  describe 'Ticker' do
    let(:ticker) do
      VCR.use_cassette('ticker') { Paytunia.get_ticker }
    end

    it 'must be an instance of Ticker' do
      ticker.should be_an_instance_of Paytunia::Api::Ticker
    end

    it 'must respond to all methods' do
      %w(high low volume bid ask midpoint at price variation currency).each do |method|
        ticker.should respond_to(method)
      end
    end

    it 'must return only decimals' do
      %w(high low volume bid ask midpoint price variation).each do |method|
        ticker.send(method).should be_an_instance_of BigDecimal
      end

      [Bignum, Fixnum].should include ticker.at.class
      ticker.currency.should eq 'EUR'
    end
  end

  describe 'Trade orders list' do
    let(:trade_orders) do
      VCR.use_cassette('trade_orders', match_requests_on: [:method, :anonymized_uri]) do
        Paytunia.list_orders
      end
    end

    it 'must be an array'do
      trade_orders.should be_an_instance_of Array
    end
  end

  describe 'Active trade orders' do
    let(:active_orders) do
      VCR.use_cassette('active_orders', match_requests_on: [:method, :anonymized_uri]) do
        Paytunia.list_active_orders
      end
    end

    it 'must all be active'do
      active_orders.each { |o| o['state'].should eq 'active' }
    end
  end

end