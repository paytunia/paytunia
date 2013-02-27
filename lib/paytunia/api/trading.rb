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

    # Returns the full market depth
    def get_depth(currency = :eur)
      depth = get("/depth/#{currency}").parsed_response

      %w{ bids asks }.each do |category|
        depth[category].map! { |order| Depth.new(order) }
      end

      depth
    end

  end
end