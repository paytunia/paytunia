module Paytunia
  module Api
    module Trading

      # Returns the active trade orders (pending_execution, active, or insufficient_funds)
      def list_active_orders
        token.get('/api/v1/trade_orders/active').body
      end

      # Returns all orders, ever
      def list_orders
        token.get('/api/v1/trade_orders').body
      end

      # Returns the ticker
      def get_ticker
        get('/api/v1/ticker')
      end

    end
  end
end