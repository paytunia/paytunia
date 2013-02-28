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

  describe 'Depth' do
    let(:depth) do
      VCR.use_cassette('depth') do
        Paytunia.get_depth(:usd)
      end
    end

    it 'should have two collections of Depth instances' do
      depth['bids'][0].should be_an_instance_of Paytunia::Api::Depth
      depth['asks'][0].should be_an_instance_of Paytunia::Api::Depth
    end
  end

  describe 'Trade orders' do

    describe 'successful creation' do
      let(:response) do
        VCR.use_cassette('trade_order_creation', match_requests_on: [:method, :anonymized_uri]) do
          Paytunia.post_trade_order(BigDecimal('10'), 'EUR', :buy, BigDecimal('30'))
        end
      end

      it 'should be a trade order' do
        response.should be_an_instance_of Paytunia::Api::TradeOrder
        response.state.should eql 'pending_execution'
        response.amount.should eql BigDecimal('10')
        response.uuid.should be_a_valid_uuid
        response.created_at.should be_an_instance_of DateTime
        response.updated_at.should be_an_instance_of DateTime
      end
    end

    describe 'illegal parameters rejection' do
      it 'should fail if amount is not a BigDecimal' do
        expect { Paytunia.post_trade_order(10, 'EUR', :sell, 20) }.to raise_error(StandardError, /Expected BigDecimal, got .* instead/)
      end

      it 'should fail with illegal currency' do
        expect { Paytunia.post_trade_order(BigDecimal('1'), 'XXX', :sell, BigDecimal('1')) }.to raise_error(StandardError, /Illegal currency/)
      end

      it 'should fail when the type is illegal' do
        expect { Paytunia.post_trade_order(BigDecimal('1'), 'EUR', :illegal, BigDecimal('1')) }.to raise_error(StandardError, /Illegal type/)
      end
    end
  end
end

