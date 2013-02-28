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

    # Posts a trade order
    #
    # ==== Attributes
    #
    # * +amount+ - The amount of Bitcoins to buy or sell
    # * +currency+ - The currency against which to trade
    # * +type+ - Whether your order is to buy or sell Bitcoins, legal values are +:buy+ and +:sell+
    # * +price+ - Limit price, creates a market order if omitted
    #
    def post_trade_order(amount, currency, type, price = nil)
      if !amount.kind_of?(BigDecimal) || (price && !price.kind_of?(BigDecimal))
        raise TypeError, "Expected BigDecimal, got #{amount.class.name} instead."
      end

      unless %w{ eur usd gbp }.include?(currency.to_s.downcase)
        raise 'Illegal currency'
      end

      unless %w{ buy sell }.include?(type.to_s.downcase)
        raise 'Illegal type'
      end

      TradeOrder.new(account.post('/trade_orders', { amount: amount, currency: currency, type: type, price: price } ))
    end

    # Gets a trade order
    #
    # ==== Attributes
    #
    # * +trade_order_id+ - UUID of the trade order to fetch
    #
    def get_trade_order(uuid)
      TradeOrder.new(account.get("/trade_orders/#{uuid}"))
    end

    # Gets the trades that happened in relation to a specific order
    #
    # ==== Attributes
    #
    # * +trade_order_id+ - UUID of the trade order
    #
    def get_trades_for_order(uuid)
      account.get("/trade_orders/#{uuid}/trades").map { |trade| Trade.new(trade) }
    end
  end
end