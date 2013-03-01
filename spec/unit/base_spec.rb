require_relative '../spec_helper'

describe 'Base class' do

  describe 'json serialization' do
    let(:ticker) do
      Paytunia::Api::Ticker.new({
        high: BigDecimal('2.23456789'),
        low: BigDecimal('1.23456789'),
        bid: BigDecimal('2.23456789'),
        ask: BigDecimal('2.23456789'),
        volume: BigDecimal('2.23456789') ,
        variation: BigDecimal('0'),
        at: 1362146028,
        price: BigDecimal('1'),
        currency: 'EUR',
        midpoint: BigDecimal('42.5')
      })
    end

    it 'must be serialized correctly to json' do
      ticker.to_json.should eql "{\"high\":2.23456789,\"low\":1.23456789,\"volume\":2.23456789,\"bid\":2.23456789,\"ask\":2.23456789,\"midpoint\":42.5,\"at\":1362146028,\"price\":1.0,\"variation\":0.0,\"currency\":\"EUR\"}"
    end
  end
end