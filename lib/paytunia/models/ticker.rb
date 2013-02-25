module Paytunia
  module Api
    class Ticker < Base
      attr_accessor :high, :low, :volume, :bid, :ask, :midpoint, :at, :price, :variation, :currency
    end
  end
end