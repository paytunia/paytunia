module Paytunia
  module Api
    class TradeOrder < Base
      attr_accessor :uuid, :amount, :currency, :price, :type, :state, :instructed_amount

      attr_reader :created_at, :updated_at

      def created_at=(s)
        if s.kind_of?(String)
          @created_at = DateTime.parse(s)
        else
          super
        end

        def updated_at=(s)
          if s.kind_of?(String)
            @updated_at = DateTime.parse(s)
          else
            super
          end
        end
      end
    end
  end
end
