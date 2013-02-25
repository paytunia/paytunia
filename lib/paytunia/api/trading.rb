module Paytunia
  module Api

    # Returns the active trade orders (pending_execution, active, or insufficient_funds)
    def list_active_orders
      account.get('/trade_orders/active')
    end

    # Returns a paginated list of orders
    def list_orders
      account.get('/trade_orders')
    end

    # Returns the ticker
    def get_ticker
      Ticker.new(get('/ticker'))
    end

  end
end