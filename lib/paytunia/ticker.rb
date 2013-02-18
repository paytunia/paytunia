module Paytunia
  class Ticker
    attr_accessor :high, :low, :volume, :bid, :ask, :midpoint, :at, :price, :variation, :currency
    include HTTParty
    base_uri 'https://bitcoin-central.net/api/v1/'


    def initialize
      result = self.class.get '/ticker'
      %w(high low volume bid ask midpoint at price variation currency).each do |attr|
        self.send("#{attr}=", result[attr])
      end
    end


  end
end