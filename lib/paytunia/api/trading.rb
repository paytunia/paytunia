module Paytunia
  module Api
    module Trading
      def list_active_orders
        token.get('/api/v1/trade_orders/active').body
      end

      def list_orders
        token.get('/api/v1/trade_orders').body
      end
    end
  end
end