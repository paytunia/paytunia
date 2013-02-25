module Paytunia
  module Api

    # Returns the list of account operations
    def get_ledger
      account.get('/account_operations')
    end

  end
end