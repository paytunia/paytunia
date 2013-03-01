module Paytunia
  module Api
    class Ticker < Base
      attrs :high, :low, :volume, :bid, :ask, :midpoint, :at, :price, :variation, :currency
    end
  end
end