module Paytunia
  module Api
    class Trade < Base
      attr_accessor :uuid, :traded_currency, :traded_btc, :currency, :price, :created_at
    end
  end
end