module Paytunia
  module Api
    module Trading
      def active_trade_orders
        self.class.get("/trade_orders/active")
      end

      def trade_orders
        result = self.class.get("/trade_orders")
        result.collect{|o| Order.new o}
      end
    end
  end
end