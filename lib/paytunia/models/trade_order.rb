module Paytunia
  module Api
    class TradeOrder < Base
      attr_accessor :uuid, :amount, :currency, :price, :type, :state, :instructed_amount, :created_at, :updated_at
    end
  end
end
