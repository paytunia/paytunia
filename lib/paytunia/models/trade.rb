module Paytunia
  module Api
    class Trade < Base
      attrs :uuid, :traded_currency, :traded_btc, :currency, :price, :created_at
    end
  end
end