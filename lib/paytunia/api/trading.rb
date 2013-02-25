module Paytunia
  module Api

    # Returns the active trade orders (pending_execution, active, or insufficient_funds)
    def list_active_orders
      token.get('/trade_orders/active').body
    end

    # Returns all orders, ever
    def list_orders
      token.get('/trade_orders').body
    end

    # Returns the ticker
    def get_ticker
      Ticker.new get('/ticker')
    end

  end
end