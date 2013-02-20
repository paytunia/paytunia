module Paytunia
  module Api
    module Account

      # Returns the list of account operations
      def get_ledger
        token.get('/api/v1/account_operations').body
      end

    end
  end
end