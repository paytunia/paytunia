require_relative '../spec_helper'

describe 'Ticker' do

  let(:ticker) do
    VCR.use_cassette('ticker') { Paytunia::Connection.get_ticker }
  end

  it 'must have respond to all methods' do
    %w(high low volume bid ask midpoint at price variation currency).each do |method|
      ticker.should respond_to(method)
    end
  end

  it 'must return decimals' do
    %w(high low volume bid ask midpoint price variation).each do |method|
      ticker.send(method).should be_an_instance_of BigDecimal
    end

    ticker.at.should be_an_instance_of Fixnum
    ticker.currency.should eq 'EUR'
  end

end
