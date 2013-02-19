module Paytunia
  class Trading
    include HTTParty
    base_uri 'https://bitcoin-central.net/api/v1/'
    basic_auth "email", "password"

    def active_trade_orders
      self.class.get("/trade_orders/active")
    end

    def trade_orders
      result = self.class.get("/trade_orders")
      result.collect{|o| Order.new o}
    end

  end
end