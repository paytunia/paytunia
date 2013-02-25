module Paytunia
  module Api

    # Returns the list of account operations
    def get_ledger
      account.get('/account_operations').map do |ao|
        AccountOperation.new(ao)
      end
    end

  end
end